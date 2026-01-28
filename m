Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD92C2D7DF3
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594978; cv=none; b=T1l2fe3K4PCxOR0VoB09M3sHmZiV34V+V5iYenINBoohgK/ukvbodzHs0p33spHehsBnBe2ET6HQLERPhbM4tgTb7dwFpwYwHFFQOm+HbVBYBQlTo4Xe2x10InFRP3dulAp7SxjB0UuyJ3HuLiWvYvCHaYhp9q2q5ZMmzdoR0Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594978; c=relaxed/simple;
	bh=TPJPDOme66fAODIgH95etwF5kwEVW4NpCyBrbrnv8PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oJagfHE/sLq4C0IFQ/tDRqfp61i0vxaoiUyrKcW0NGk0xnW0ozV9jWTBqU9/jYYAvXxLYl8EYYHbJBkxFCf3ENDuS6l/poZAhpVZcwfIhnhppwuVfMu/jGK3D35OHhGpG4nASh9Jk+Q27oPNv875VeiT0KlFGjZW8AYPtiaa3wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1769594970-1eb14e7c0137290001-0c9NHn
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id O3s3E7PRvfVJ8Zj0 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 28 Jan 2026 18:09:30 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 28 Jan
 2026 18:09:30 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Wed, 28 Jan 2026 18:09:30 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from [10.32.64.5] (10.32.64.5) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 28 Jan
 2026 18:08:46 +0800
Message-ID: <3af9f754-d282-485c-a3f2-49a230bfe143@zhaoxin.com>
Date: Wed, 28 Jan 2026 18:07:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dpc: Increase pciehp waiting time for DPC recovery
To: Bjorn Helgaas <helgaas@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH] PCI: dpc: Increase pciehp waiting time for DPC recovery
CC: <mahesh@linux.ibm.com>, <oohall@gmail.com>, <bhelgaas@google.com>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <CobeChen@zhaoxin.com>,
	<TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>, Lukas Wunner
	<lukas@wunner.de>
References: <20260123202140.GA84703@bhelgaas>
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
In-Reply-To: <20260123202140.GA84703@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 1/28/2026 6:09:29 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1769594970
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3796
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.153689
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



=E5=9C=A8 2026/1/24 4:21, Bjorn Helgaas =E5=86=99=E9=81=93:
>=20
>=20
> [=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E6=9D=A5=E8=87=AA=E5=A4=96=E9=83=A8=
=E5=8F=91=E4=BB=B6=E4=BA=BA =E8=B0=A8=E9=98=B2=E9=A3=8E=E9=99=A9]
>=20
> [+cc Lukas, pciehp expert and author of a97396c6eb13]
>=20
> On Fri, Jan 23, 2026 at 06:40:34PM +0800, LeoLiu-oc wrote:
>> Commit a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC")
>> amended PCIe hotplug to not bring down the slot upon Data Link Layer Sta=
te
>> Changed events caused by Downstream Port Containment.
>>
>> However, PCIe hotplug (pciehp) waits up to 4 seconds before assuming tha=
t
>> DPC recovery has failed and disabling the slot. This timeout period is
>> insufficient for some PCIe devices.
>> For example, the E810 dual-port network card driver needs to take over
>> 10 seconds to execute its err_detected() callback.
>> Since this exceeds the maximum wait time allowed for DPC recovery by the
>> hotplug IRQ threads, a race condition occurs between the hotplug thread =
and
>> the dpc_handler() thread.
>=20
> Add blank lines between paragraphs.
>=20
> Include the name of the E810 driver so we can easily find the
> .err_detected() callback in question.  Actually, including the *name*
> of that callback would be a very direct way of doing this :)
>=20
> I guess the problem this fixes is that there was a PCIe error that
> triggered DPC, and the E810 .err_detected() works but takes longer
> than expected, which results in pciehp disabling the slot when it
> doesn't need to?  So the user basically sees a dead E810 device?
>=20
Yes, this patch is to solve this problem.

> It seems unfortunate that we have this dependency on the time allowed
> for .err_detected() to execute.  It's nice if adding arbitrary delay
> doesn't break things, but maybe we can't always achieve that.
>=20
I think this is a feasible solution. For some PCIE devices, executing
the .err_detect() within 4 seconds will not have any impact, for a few
PCIE devices, it might increase the execution time of pciehp_ist().
Without this patch, PCIE devices may not be usable and could even cause
more serious errors, such as a kernel panic. For example, the following
log is encountered in hardware testing:

list_del corruption, ffff8881418b79e8->next is LIST_POISON1
(dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:56!
invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
...
Kernel panic - not syncing: Fatal exception

> I see that pci_dpc_recovered() is called from pciehp_ist().  Are we
> prepared for long delays there?
>=20
This patch may affect the hotplug IRQ threads execution time triggered
by DPC, but it has no effect for normal HotPlug operation, e.g.
Attention Button Pressed or Power Fault Detected. If you have better
modification suggestions, I will update to the next version.

>> Signed-off-by: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
>> ---
>>  drivers/pci/pcie/dpc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index fc18349614d7..08b5f275699a 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -121,7 +121,7 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
>>        * but reports indicate that DPC completes within 4 seconds.
>>        */
>>       wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
>> -                        msecs_to_jiffies(4000));
>> +                        msecs_to_jiffies(16000));
>=20
> It looks like this breaks the connection between the "completes within
> 4 seconds" comment and the 4000ms wait_event timeout.
>=20
Thanks for your suggestion, I will change it in the next version.

Yours sincerely.
LeoLiu-oc

>>       return test_and_clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
>>  }
>> --
>> 2.43.0
>>

