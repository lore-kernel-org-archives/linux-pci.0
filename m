Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20180723195711.0a3c9301@t450s.home>
References: <20180724000944.7671.64284.stgit@gimli.home>
 <20180724001310.7671.41243.stgit@gimli.home>
 <abc86e6b-7df5-a84c-7e98-107c605812c6@kernel.org>
 <20180723195711.0a3c9301@t450s.home>
From: Sinan Kaya <Okaya@kernel.org>
Date: Mon, 23 Jul 2018 19:20:41 -0700
Message-ID: <CAK9iUCPG-H3vWjiEnjAgr_nWEf=0Sn+AvRt68_Sg16Zw8TobRg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: NVMe device specific reset quirk
To: Alex Williamson <alex.williamson@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 7/23/18, Alex Williamson <alex.williamson@redhat.com> wrote:
> On Mon, 23 Jul 2018 17:40:02 -0700
> Sinan Kaya <okaya@kernel.org> wrote:
>
>> On 7/23/2018 5:13 PM, Alex Williamson wrote:
>> > + * The NVMe specification requires that controllers support PCIe FLR,
>> > but
>> > + * but some Samsung SM961/PM961 controllers fail to recover after FLR
>> > (-1
>> > + * config space) unless the device is quiesced prior to FLR.
>>
>> Does disabling the memory bit in PCI config space as part of the FLR
>> reset function help? (like the very first thing)
>
> No, it does not.  I modified this to only clear PCI_COMMAND_MEMORY and
> call pcie_flr(), the Samsung controller dies just as it did previously.
>
>> Can we do that in the pcie_flr() function to cover other endpoint types
>> that might be pushing traffic while code is trying to do a reset?
>
> Do you mean PCI_COMMAND_MASTER rather than PCI_COMMAND_MEMORY?

Yes

>  I tried
> that too, it doesn't work either.  I'm not really sure the theory
> behind clearing memory, clearing busmaster to stop DMA seems like a
> sane thing to do, but doesn't help here.

Let me explain what I guessed. You might be able to fill in the blanks
where I am completely off.

We do vfio initiated flr reset immediately following guest machine
shutdown. The card could be fully enabled and pushing traffic to the
system at this moment.

I don't know if vfio does any device disable or not.

FLR is supposed to reset the endpoint but endpoint doesn't recover per
your report.

Having vendor specific reset routines for PCIE endpoints defeats the
purpose of FLR.

Since the adapter is fully functional, i suggested turning off bus
master and memory enable bits to stop endpoint from sending packets.

But, this is not helping either.

Those sleep statements looked very fragile to be honest.

I was curious if there is something else that we could do for other endpoints.

No objections otherwise.

>
> Alex
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
