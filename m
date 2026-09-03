Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37D2282F20;
	Thu,  3 Sep 2026 01:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397711; cv=none; b=BpuVcPkJatbuLoMcJTbLsCssuxwkiGw937DdKLoo4BqscclZwVEd5UgcvtOwt8D3/kzmD4qyRU0qEErXWU0m+3Q+PxaG76T0y0m4Btm9qh7A0XJcBQ8Oa+5oc+06IxsRCpdicHOdv1mQajhGXuix24jOZk5DoJiNh273mFw9HaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397711; c=relaxed/simple;
	bh=XpWzIn8Uvb7NNHEaVjshPZhpM82BAdAdxiGWa5vs8rE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Pvdf27D9w03rQ1cG61mo/EitmnbCxzAD7hNwxKCS2u/1D4SzU1xW6ReTLBuEC0VvqkeMUpvgLHsKGCoLxltjBkaf1bzsZQcAFR591iBi4A2CQxH6kb5+MTHDY5ffABoFsIGIdKJyptuUwUMiCMx/+nmCVmMIFebgBCTf+0qzSFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=RqnpHb89; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="RqnpHb89"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1788397596;
	bh=sn4Zqvuy3iv8MXIhtE8ntlyyLJ+J0+s0jH6g+E8SxjY=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=RqnpHb89/01yM+Bz0hysKu2yS9fOhB/gzyhw2zbf7YZF1TIOGecEq3pHEq1jxf5cW
	 pptd9UVk0Fn+kfIFE7vEQS9QUo3AUbn6Ulmfes2BldVr2RR9mMtinBM9ILqbbN/hma
	 JOuQVSvV+g0ouNGQIydZ+ul2tIlU5kW64VEX1P1g=
X-QQ-mid: zesmtpgz6t1788397590t809805a0
X-QQ-Originating-IP: VhXi++IEq6mjKwdvVbXNY7Td/lOsJov/j5KV2ygThxU=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Sep 2026 09:06:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15480183741827357636
EX-QQ-RecipientCnt: 16
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=5aa6fa5638c6e4ef04b289541629de5e53ccc8327148dde49673ae679c24;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 03 Sep 2026 09:06:25 +0800
Message-Id: <DL5A18T0GPB5.32JI7ECB3UCRX@linux.spacemit.com>
Subject: Re: [BUG] PCI: spacemit-k1: port C probe hard-hangs a CPU with one
 endpoint on Milk-V Jupiter
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Alex Elder" <elder@riscstar.com>, "Manivannan Sadhasivam"
 <mani@kernel.org>, <spacemit@lists.linux.dev>, "Bruno Banelli"
 <bbanelli@gmail.com>, "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
Cc: <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>, "Yixun
 Lan" <dlan@kernel.org>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Krzysztof Wilczynski" <kwilczynski@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Danilo
 Krummrich" <dakr@kernel.org>, "Uwe Kleine-Koenig"
 <u.kleine-koenig@baylibre.com>, "Javier Martinez Canillas"
 <javierm@redhat.com>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260825052249.66921-1-bbanelli@gmail.com>
 <c24pt2ls62rxxg77xjbng7dmiflgdjlqd3mkoxehc2rvjgh7ai@dcxvmau3ykmt>
 <7a29717b-dc62-4421-b783-7b78e4375268@riscstar.com>
In-Reply-To: <7a29717b-dc62-4421-b783-7b78e4375268@riscstar.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OegHrGdQ9dQUM4rcL/UVOoWjrJLz5Nzb+TUFTx9WDCS/0LAq3sT6vH3w
	6AdDiFHcsZrwbamOt53PT02mSiYLUkBPQe8b/i1vkM+DAJweZ7vuGsCaxlUSnkccplSujVi
	v7wE4m+MjxB5f3VqTNRTS9PfvH7L745KMN1pBngIzRSxNQqQc3lJiKrybCdwhJ7ytb9ASBI
	SOgGJwAsFwP6S6hIve5vRGRjo9Pq/kGfU3q+zU6Z16icv301xRAD7EoeGMo5amb6nXAoS/u
	n3jIjX7L46pAMhuFMEOsfcmyoCy3VOZcgdrAy19t+8F2yN4L3di1y492cgD+EVUDpgq70u8
	06SRwVqeCzXHOxofTq93/osYqdXEvrV0+tAoRzp7CYmtIFLkaIGLy9oH8el8r+v/B0Ih8cU
	e/pa0ti9LXzZedI9dL8ETMy0+ZOU618H5klM/70jVfJtERUAa3lSCW4XYAKhp6YeYNsLKnq
	M/Pb6AIrOph3lluQ9ZjHOy6aVbXB6/qmbp2bD3qry2t3GUmGdmhw9lm0W2+0xb0WZ2zXI1k
	bgHvmJKFtjvP11gLRl3pbvaUwvVAQnwZfxbOEt+YG+vbuUdOKul0rsbq4U5EvuquoMUBj/t
	WXSPne41/uaZ5D9ZwuOHSQpEUBSNL1JY+9HMKOknAnKppuNQ/JaQNAo39bURWmY7iadMJ9t
	g6EKdUhT/E9LzN3to3paW5pHSs5fv7fdDTrXAXF1vYii1UCJA/pN1hanKXv1q/zNfQ0yIJ/
	GnwhIfrmLJ3L3exHyVPvSim4rHTL4VMU7Lke86wfKHJ3wfcNpCrnj+okSL4//2CRN6vBRNl
	ccw0SJoJNu4BM6SGVfaqB40w37Qi10rhJpZe12m3qNe/ccS62KYze3MMDCp7COAqRLha9Kh
	I92V3DnbZ4ag5uZkNhxLZn/GGnUg3DpV+BZrgkMpf6YJmTAH7TzBiCi7B2/3dqgQqxmlgic
	pkozDRFAZD3OmS2m1ftuD4X4xM2D5DEmhKewq2qm9uFGT7Ui6ypjEbgjmeFqi9CYmXSdnJW
	RouKzzAL2WvVMpofuyjdB/VBJuzTe3rb7CEE419g/3H6OQzw8YHV3Iir89oSr4MA411TnBg
	rX7p2Ae+JpDOViZCGivtFmZxG/6tZeFb3WQ7OzbZGMN
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

--5aa6fa5638c6e4ef04b289541629de5e53ccc8327148dde49673ae679c24
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Sep 2, 2026 at 9:56 PM +08, Alex Elder wrote:
> On 9/2/26 8:42 AM, Manivannan Sadhasivam wrote:
>> On Tue, Aug 25, 2026 at 07:22:49AM +0200, Bruno Banelli wrote:
>>> Hi,
>>>
>>> On a Milk-V Jupiter, probing the PCIe controller at ca800000 (port C, t=
he
>>> card slot) permanently wedges the CPU that runs the probe when one
>>> particular add-in card is installed.  The CPU stops responding to NMI, =
and
>>> because the probe is asynchronous, kernel_init() then blocks forever in
>>> async_synchronize_full() and the machine never finishes booting.
>>>
>>> The same card, in the same slot, on the same board, does *not* hang the
>>> vendor 6.6 kernel -- it reports "Phy link never came up" and boots norm=
ally.
>>> Six other cards do not hang mainline either.  So whatever the electrica=
l
>>> cause, this looks like a robustness problem in pcie-spacemit-k1: an end=
point
>>> should not be able to hang a host-side DBI register access.
>>>
>>>
>>> HARDWARE
>>> --------
>>>    Milk-V Jupiter v1.1, SpacemiT M1 (socinfo: CPU[M1-8571] REV[C] DRO[1=
30]),
>>>    16 GiB LPDDR4X.
>>>    Firmware: stock vendor U-Boot 2022.10 (k1-bl-v2.2.9), unmodified.
>>>    Port B (ca400000, M.2) has a Samsung PM9B1 NVMe and works throughout=
.
>>>    Port C (ca800000) is the card slot -- an x8-length connector, silksc=
reened
>>>    PCIE_X2, wired x2.
>>>
>>>
>>> REPRODUCED ON
>>> -------------
>>>    v7.1 and v7.2, riscv defconfig (plus PHY_SPACEMIT_K1_USB2, USB_DWC3,
>>>    SPACEMIT_K1_TSENSOR, IGB, IGC, NVMe/ext4 built in).
>>>    gcc 13.3.0 (cross) and gcc 16.2.0 (native, Debian sid).
>>>    Identical failure in all combinations.  Not a regression -- port C h=
as
>>>    never worked with this card on mainline.
>>>
>>> Command line:
>>>    console=3DttyS0,115200 earlycon root=3D/dev/nvme0n1p2 rootwait rw
>>>    swiotlb=3D65536 clk_ignore_unused pd_ignore_unused
>>>
>>>
>>> SYMPTOM
>>> -------
>>> Port C prints its address ranges and then never speaks again.  (Log bel=
ow is
>>> from a run with port B disabled in DT, so nothing is interleaved.)
>>>
>>>    [ 1.290074] spacemit-k1-pcie ca800000.pcie: host bridge /soc/pcie-bu=
s/pcie@ca800000 ranges:
>>>    [ 1.297283] spacemit-k1-pcie ca800000.pcie:       IO 0x00b7002000..0=
x00b7101fff -> 0x0000000000
>>>    [ 1.312783] spacemit-k1-pcie ca800000.pcie:      MEM 0x00a0000000..0=
x00afffffff -> 0x00a0000000
>>>    [ 1.326753] spacemit-k1-pcie ca800000.pcie:      MEM 0x00b0000000..0=
x00b6ffffff -> 0x00b0000000
>>>    [22.348490] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>>>    [22.351764] rcu:     4-...0: (12 GPs behind) idle=3D051c/1/0x4000000=
000000000 softirq=3D43/43 fqs=3D1908
>>>    [22.367040] Sending NMI from CPU 2 to CPUs 4:
>>>    [32.367049] After 10 seconds, these CPUS still haven't responded to =
the NMI: 4
>>>
>>> The CPU ignoring an NMI for ten seconds is why I read this as an MMIO a=
ccess
>>> that never receives a completion rather than a spin or a deadlock.
>>>
>>>
>>> LOCALISATION
>>> ------------
>>> I added a dev_info() before each step of k1_pcie_init() (patch at the e=
nd of
>>> this mail).  The last marker port C prints is the one immediately befor=
e the
>>> first DBI access:
>>>
>>>    [1.347050] spacemit-k1-pcie ca800000.pcie: K1DBG 1 toggle_soft_reset
>>>    [1.362635] spacemit-k1-pcie ca800000.pcie: K1DBG 2 enable_resources
>>>    [1.370918] spacemit-k1-pcie ca800000.pcie: K1DBG 3 first DBI write (=
vendor/device ID)
>>>    <nothing further>
>>=20
>> Sounds weird that an endpoint is causing DBI write hang.
>>=20
>> Can Alex or someone from Spacemit look into this issue?
>
> I think Yixun Lan or maybe Troy Mitchell should investigate.
>
> I have not done anything on the Milk-V Jupiter and have no
> access to any board of that type.
This seems to be device-specific. Some of our team members are already look=
ing into it.

--=20
Troy Mitchell


--5aa6fa5638c6e4ef04b289541629de5e53ccc8327148dde49673ae679c24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIMEABYKACsWIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCapjIEQ0caUB0cm95LXku
b3JnAAoJEJgJ74D5MzQv/3sA/3cB2V5ShRbpFKlrOGG/ak5AYZnPZSI4Cj9mD/S8
v+bfAP9TR48gN2ZQ6yxgPavM/EQxD9OF1y6BdJfsu6pnp6BtAA==
=unDq
-----END PGP SIGNATURE-----

--5aa6fa5638c6e4ef04b289541629de5e53ccc8327148dde49673ae679c24--
