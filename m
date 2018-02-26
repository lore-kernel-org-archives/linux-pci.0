Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <CAL85gmCQjVb4i6+LUBKXsqM1cRTt_YWLvWxz+U4e_ahE+8dE1w@mail.gmail.com>
References: <1519433209-14581-1-git-send-email-fkan@apm.com>
 <CAJZ5v0hDM=DtBZA1awz7ao62cpe4CAhUz1L7KkLTv=G3YQhuEw@mail.gmail.com>
 <CAJZ5v0jJMODOsZV41Jn18LCtttMemFQyXonJxZnUgXday8_4iw@mail.gmail.com>
 <20180224135946.GA1735@wunner.de>
 <CAJZ5v0gDDUKy_vzjBiBiBLThsaeZxwpi7t9se0VKPsB1eo778Q@mail.gmail.com>
 <CAL85gmCQjVb4i6+LUBKXsqM1cRTt_YWLvWxz+U4e_ahE+8dE1w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Feb 2018 10:38:04 +0100
Message-ID: <CAJZ5v0h07kYMyOtjMA1ezUVnFQW_ixtMUDHUPAQXMhmTjcawPg@mail.gmail.com>
Subject: Re: [PATCH] PCIe bridge deferred probe breaks suspend resume
To: Feng Kan <fkan@apm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Linux PM <linux-pm@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Feb 25, 2018 at 5:28 PM, Feng Kan <fkan@apm.com> wrote:
> On Sun, Feb 25, 2018 at 1:29 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Sat, Feb 24, 2018 at 2:59 PM, Lukas Wunner <lukas@wunner.de> wrote:
>>> On Sat, Feb 24, 2018 at 10:47:26AM +0100, Rafael J. Wysocki wrote:
>>>> On Sat, Feb 24, 2018 at 10:35 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>> > On Sat, Feb 24, 2018 at 1:46 AM, Feng Kan <fkan@apm.com> wrote:
>>>> >> This is not a patch, but rather a question regarding the deferred
>>>> >> probe's effect on PCIe PM ordering. This happens on our system
>>>> >> which defer the probing of root bridge due to  the IOMMU not being
>>>> >> ready. Because of the deferred action, the bridge is moved to the
>>>> >> end of the dpm_list which results in incorrect suspend and resume
>>>> >> sequence.
>>>> >>
>>>> >> In the cases I have seen, the bridge is always reordered because of
>>>> >> startup sequence. They are always place after the endpoint. If that
>>>> >> is the case the following code should be able to prevent such cases.
>>>> >> However, is there some cases here that would violate such situation?
>>>> >
>>>> > The code in dd.c assumes that the device being probed has no children
>>>> > (or consumers, for that matter) and so it is safe to move it to the
>>>> > end of the list.
>>>> >
>>>> > If the device has children (or consumers), moving it to the end of the
>>>> > list by itself doesn't work, which is the case for you.
>>>> >
>>>> > You can try to replace the device_pm_move_last(dev) in
>>>> > deferred_probe_work_func(struct() with device_reorder_to_tail(), but
>>>> > that has to be called under device_links_read_lock/unloc () and
>>>> > device_pm_lock/unloc() (in the right order).
>>>>
>>>> Alternatively, you can replace your !dev_is_pci(dev) check with a
>>>> check for the presence of children or consumers and only move the
>>>> device to the end of the PM list if there are not any.  That would
>>>> kind of make sense, but it may break other assumptions in the deferred
>>>> probing mechanism which I don't recall ATM.
>>>>
>>>> Or avoid deferred probing of the host bridge driver entirely.  I guess
>>>> you can use it with limited functionality until the IOMMU driver is
>>>> ready and switch over to the fully functional operation mode when that
>>>> happens, but that would need to hook into the IOMMU code somehow.
>>>
>>> Or model the root bridge's dependency on the iommu using a device link:
>>> https://www.kernel.org/doc/html/latest/driver-api/device_link.html
>>
>> Apparently, there are children registered under the bridge device
>> before the driver for it is probed.
>
> Yes, so the order seems to be like this:
> 1. root port and endporint is enumerated and added to dpm_list
> 2. root port probed and deferred
> 3. iommu probed and successful
> 4. root port probed again and successful -> moved to last in dpm_list
> 5. endpoint probed and successful
>
> I guess another approach would be to prevent 1 from happening by not
> adding to dpm_list until the probe is successful.

No, system-wide suspend/resume of PCIe devices is handled by the PCI
bus type layer in part, so they have to be in dpm_list from the
outset.  Root ports, as their parents, need to be there before the
endpoints.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
