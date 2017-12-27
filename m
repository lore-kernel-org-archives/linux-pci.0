Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:11842 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750908AbdL0IOb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Dec 2017 03:14:31 -0500
Subject: Re: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
To: Alexandru Chirvasitu <achirvasub@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC: Dexuan Cui <decui@microsoft.com>, Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        "Mihai Costache (Cloudbase Solutions SRL)" <v-micos@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        KY Srinivasan <kys@microsoft.com>
References: <ec3a298b-27a3-f3fe-ea8d-a777669104ba@cn.fujitsu.com>
 <20171220131929.GC24638@arch-chirva.localdomain>
 <20171220194506.GD24638@arch-chirva.localdomain>
 <20171221022356.GE24638@arch-chirva.localdomain>
 <1bd74ca3-afca-9d61-6911-61250f459891@cn.fujitsu.com>
 <20171222142053.3cbhi2nhh24w7yoo@D-69-91-141-110.dhcp4.washington.edu>
 <KL1P15301MB000676F3F8C9A5AC8C489E75BF020@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20171222222917.GA1138@arch-chirva.localdomain>
 <KL1P15301MB00064E9E767F9395744F42A3BF030@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <alpine.DEB.2.20.1712231432210.1853@nanos>
 <20171223200112.GC1138@arch-chirva.localdomain>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <548c814c-7e24-00c0-3436-26f2704cb427@cn.fujitsu.com>
Date: Wed, 27 Dec 2017 16:14:23 +0800
MIME-Version: 1.0
In-Reply-To: <20171223200112.GC1138@arch-chirva.localdomain>
Content-Type: text/plain; charset="gbk"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alexandru,

At 12/24/2017 04:01 AM, Alexandru Chirvasitu wrote:
> On Sat, Dec 23, 2017 at 02:32:52PM +0100, Thomas Gleixner wrote:
>> On Sat, 23 Dec 2017, Dexuan Cui wrote:
>>
>>>> From: Alexandru Chirvasitu [mailto:achirvasub@gmail.com]
>>>> Sent: Friday, December 22, 2017 14:29
>>>>
>>>> The output of that precise command run just now on a freshly-compiled
>>>> copy of that commit is attached.
>>>>
>>>> On Fri, Dec 22, 2017 at 09:31:28PM +0000, Dexuan Cui wrote:
>>>>>> From: Alexandru Chirvasitu [mailto:achirvasub@gmail.com]
>>>>>> Sent: Friday, December 22, 2017 06:21
>>>>>>
>>>>>> In the absence of logs, the best I can do at the moment is attach a
>>>>>> picture of the screen I am presented with on the  boot
>>>>>> attempt.
>>>>>> Alex
>>>>>
>>>>> The panic happens in irq_matrix_assign_system+0x4e/0xd0 in your picture.
>>>>> IMO we should find which line of code causes the panic. I suppose
>>>>> "objdump -D kernel/irq/matrix.o" can help to do that.
>>>>>
>>>>> Thanks,
>>>>> -- Dexuan
>>>
>>> The BUG_ON panic happens at line 147:
>>>                     BUG_ON(!test_and_clear_bit(bit, cm->alloc_map));
>>>

There are 2 bugs in your laptop:

   1. Hard lockups on both CPUs after login
   2. panic with "apic=debug"

For the 2th bug, please try the following patch(need Thomas confirmation
:) ) in Linux 4.15-rc5. I think it can fix the panic.

If the 2th bug fixed, let's back to the 1th bug:

Is Linus current head 4.15-rc5 bad as well?

If yes, Please using "apic=debug" and give the dmesg log.

Thanks,
	dou.

------------------------8<-------------------------------------------

irq/matrix: Remove the overused BUGON() in irq_matrix_assign_system()

Currently, x86 marks the preallocated legacy interrupts when initializing
IRQ(native_init_IRQ), but will clear them if they are not activated in
vector_configure_legacy().

So, in irq_matrix_assign_system(), replacing an legacy vector which may
not allocated in a cpumap->alloc_map[] with a system vector will trigger
the BUGON();

Remove the BUGON().

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
  kernel/irq/matrix.c | 5 +++--
  1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 0ba0dd8863a7..876cbeab9ca2 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -143,11 +143,12 @@ void irq_matrix_assign_system(struct irq_matrix 
*m, unsigned int bit,
  	BUG_ON(m->online_maps > 1 || (m->online_maps && !replace));

  	set_bit(bit, m->system_map);
-	if (replace) {
-		BUG_ON(!test_and_clear_bit(bit, cm->alloc_map));
+
+	if (replace && test_and_clear_bit(bit, cm->alloc_map)){
  		cm->allocated--;
  		m->total_allocated--;
  	}
+
  	if (bit >= m->alloc_start && bit < m->alloc_end)
  		m->systembits_inalloc++;

-- 
