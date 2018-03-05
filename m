Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH V2] PM / core: fix deferred probe breaking suspend resume
 order
To: "Rafael J. Wysocki" <rafael@kernel.org>, Feng Kan <fkan@apm.com>
References: <1519942514-3350-1-git-send-email-fkan@apm.com>
 <CAJZ5v0gncVMpQCc=kvuSdyy-+zPrdYOiA=pA54d538zTDz6rEA@mail.gmail.com>
Message-ID: <d24a66fa-de5c-ba02-dafb-ee554a3032a8@ti.com>
Date: Mon, 5 Mar 2018 13:54:27 -0600
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gncVMpQCc=kvuSdyy-+zPrdYOiA=pA54d538zTDz6rEA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Linux PM <linux-pm@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Toan Le <toanle@apm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On 03/02/2018 03:11 AM, Rafael J. Wysocki wrote:
> [+Greg]
> 
> On Thu, Mar 1, 2018 at 11:15 PM, Feng Kan <fkan@apm.com> wrote:
>> When bridge and its endpoint is enumerated the devices are added to the
>> dpm list. Afterward, the bridge defers probe when IOMMU is not ready.
>> This causes the bridge to be moved to the end of the dpm list when
>> deferred probe kicks in. The order of the dpm list for bridge and
>> endpoint is reversed.
>>
>> Add reordering code to move the bridge and its children and consumers to
>> the end of the pm list so the order for suspend and resume is not altered.
>> The code also move device and its children and consumers to the tail of
>> device_kset list if it is registered.
> 
> I assume that this has been tested and works as expected.

isn't it the same as https://lkml.org/lkml/2015/9/10/248? (in general)

And wouldn't device links solve the issue?

commit 9ed9895370aedd6032af2a9181c62c394d08223b
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Sun Oct 30 17:32:16 2016 +0100

    driver core: Functional dependencies tracking support

    Currently, there is a problem with taking functional dependencies
    between devices into account.

My understanding of device links is that they were introduced exactly to fix
such kind of issues and explicitly define dependencies between devices in code.

But, I could be missing smth... sry if this is the case.

-- 
regards,
-grygorii

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
