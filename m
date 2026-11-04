Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801715;
	b=5HtcmGYK9WSXVnl5UE+gPfEhffkSQm922uZT0TDfRM/Nr6gwg7FgJNN3dlKo2RVQ2rh4
	 yCLNGYR6J5DAqf/UPBJFyEtK0ims51+C27+5MmNZHC7YvZeaqNADmZSyxuOiyKjOJ6AVA
	 iR1Fl6iwRIZ278F4h1tjyq2dRxfmcswXKg66ldNRK5zIVAljsAe/xM6TvSDAPJQTI2tuB
	 ff7AehXOFc7sZ0VY76fwCaJE0MsvfcDz4pgZ/Jbs5yXwSeYZKX/eqUjsArH6d/Tbn6Kfh
	 WEftmdTyeUPr3JnJkxLTtmlcj9Gn9IGxHa+xV7dEcl5dH7i7sck44883cDEKkC1MubA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801715;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=YRFzX9U45u392R6CS3S9srqLygNa9Vb4srT2gSOpYyY=;
	b=Gza/HDqzWPJtOXJmDu3B/z6FzSoIRG87EHuj+oRjhY6+hPrFG/3I58ckZNHan8ATqMEB
	 8GmK851psAUChNXUFSwozepYXp0bH1brDL9KxI9GmrUKFRFd8X7OCTR1ABGlsuyus31AY
	 eTebNiUOAnJjevdUAVheD/QDAo/6ItupmPAEc4ilnzED9ClfEhYxEobNpTZHNpXoF7mEr
	 FwpJlW6vGEIYCcwuBtisFS4mq5issnUxBMHqRHo7nMN9JxEPQy05un+90E6PbPdKGhkwD
	 Djs/SCdBSliQsgG9GTBoY4HgWh0bqiPYWp8eDT9J1BqBNC/RgnYWuMJq66GOlz8Ob+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=M9wjH8Ka;
	arc=none smtp.remote-ip=54.204.34.129
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C07606A330;
	Wed,  4 Nov 2026 14:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8C07606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=M9wjH8Ka
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1793801659;
	bh=YRFzX9U45u392R6CS3S9srqLygNa9Vb4srT2gSOpYyY=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=M9wjH8KaPJl5odAg4TcCw1vuqIexC9g/6N/vFvVvPwhIvmeQxBQ/8IM6inUzsRGh/
	 Sso9I9ilFIpK45stJzrONuEYLnouAQr3gmnY7H20RzfY5UIjtgvZJCRoZKe/JddQZ6
	 TRDtyb6sxqySu6IB/2cOXrNzll/2aowUxnGblGaA=
X-QQ-mid: zesmtpsz3t1793801657t27ae4659
X-QQ-Originating-IP: VHZFg6dY0HEn9gNaE2tnlCiu8hVYZVO1me2iozeib+M=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Nov 2026 22:14:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14208902309344038913
EX-QQ-RecipientCnt: 18
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=781b55b6c1a4b8d869ac8afe61faab8498bc4cbf4cf36fd0c52106658e40;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 04 Nov 2026 14:14:14 +0000
Message-Id: <DMMHM7OIO97H.2SHNC575QC4PY@linux.spacemit.com>
Cc: "Rob Herring" <robh@kernel.org>, "Yixun Lan" <dlan@kernel.org>, "Troy
 Mitchell" <troy.mitchell@linux.spacemit.com>, "Ping-Ke Shih"
 <pkshih@realtek.com>, "Anirudh Srinivasan"
 <asrinivasan@oss.tenstorrent.com>, "Alex Elder" <elder@riscstar.com>,
 "Vladimir Oltean" <vladimir.oltean@nxp.com>,
 =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
 <u.kleine-koenig@baylibre.com>, "Pengpeng Hou" <pengpeng@iscas.ac.cn>,
 "open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
 "open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: spacemit: Ignore PERST# bit for controllers
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Ali Tariq" <alitariq45892@gmail.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan
 Sadhasivam" <mani@kernel.org>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.21.0-reader-ipc4
References: <20261104140750.761330-1-alitariq45892@gmail.com>
In-Reply-To: <20261104140750.761330-1-alitariq45892@gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MMP68wjQN2EwNcNLqNECurWnKOmMv96dvv8GQWQep79nn3kixqaepqiT
	ZEmTss6b5P52V3gxN+xhin5F7PsUEx8k0Xy94SQ8FYlhFyA5YflgzKn+IuqK295fbcknUaY
	sFmV+I8xWQfZVJwbOYD2ZT6uZAN5bmrAuTEd+QJ/isi8XWoTbfvXp5CMqN3ifZrARdnp60k
	Ud7T/VBB6O+vUWnmb0w+3cYj6zM1MDHVi1GaoRUvzMsnZ/ns3hufifI+uluLJnXNL4QJuTI
	yBhAfSK7sSC8hwD8ft25+hx5xpUqD2KTngZxndhTWxlizk0WUXi0UJl9L3U9TRpWCYoUMPb
	tWOGTJ3kydL0p+7IDIeAEy0Fdx83CKwa7FkrvR21cA4AOiPRCT/8In56rETj6X0IbdDy83n
	tqkzkCwLsApSZfE96Me3ybKdf01mwMIbYLyBKipefsgUu9l49gylEjrFtGjfkx2o0pmYXN7
	GgKF+DZTx86yXkOvc1TeeqKKflotPoSMU/vfsUa2lkoA70nPYFkmshNfhU3klTtpLbq299y
	u6X7BkUbnOTkhJszE6yk481XuNJRXkvVbq3ZGw3hv93wC3mfMiblMWT8oO6h+FnyZnea6te
	IeVfsZSwi+D8FeO/vbrjzCWzWnrASDmB94IF8/9aj9bMMNNG9HqNxDI4xsnz+e6qN4NwdRe
	V/2bGSDe1k0rxbyGFFfELmX/cz4GWxNR0liVK+tQAw3zIMd9L6gmBlQ+PbdMLKfeKio/e0C
	CFMvj4tyzYBB68iKcFRRC6gFYHzMBQBJJDfnV00Dml/ogw1wSQEk3F9uRLCCMPEtcC4j4k2
	CopQnQhkg6FNHsyRABlh7zLWMEzwqgtM8N2cQyRxJnQ9sEnmMRooMBtWPz7R6Kdc7exsjPT
	ElEu/ACm70RSkRW5WhtJ6QlE1rGE0krZFZIyxRZO4GIHbgwIMtOUgLMflkYld/q3CCh4RUV
	JGz0Xbt/T0p4lnCxKT0FDy17lDc4ADwXIr/rtY9R9dwFjAmBlOJ3yQAJ5KZVDBUcAYrYAEv
	yUMxSkh1qhUx9rDgrtTfrAZ+51avtALrdVg2hHb5hEglO2zHVU0QzfcsYtHZJ0ux6TObG+j
	k7rwONrzoTXYECjnx1HXPn9VDDgycQOCA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

--781b55b6c1a4b8d869ac8afe61faab8498bc4cbf4cf36fd0c52106658e40
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Nov 4, 2026 at 2:07 PM GMT, Ali Tariq wrote:
> The k1_pcie_init() does not set PCIE_IGNORE_PERSTN bit of the
> control logic register, which causes controller to reset itself once
> PERST# signal is asserted even when acting as host.
> On Orange Pi RV2 (SpacemiT K1), this resets the controller and wipes
> the IDs. k1_pcie_deinit() leaves PERST# asserted, so when k1_pcie_init()
> runs again, its first DBI access hangs the CPU.
>
> Set PCIE_IGNORE_PERSTN bit of the control logic register of APMU
> in k1_pcie_init() before enabling resources so controllers
> dont end up resetting themselves when PERST# signal is asserted.
>
> Fixes: ff64e078e45f ("PCI: spacemit: Add SpacemiT PCIe host driver")
> Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
> ---
> Hang log: https://kernelci.cloud-v.co/scheduler/job/420
> Fixed Log: https://kernelci.cloud-v.co/scheduler/job/430
> ---
>  drivers/pci/controller/dwc/pcie-spacemit-k1.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/=
controller/dwc/pcie-spacemit-k1.c
> index 92a71ea90ac3..af6028e8825a 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> @@ -47,6 +47,7 @@
> =20
>  #define PCIE_CONTROL_LOGIC			0x0004
>  #define PCIE_SOFT_RESET			BIT(0)
> +#define PCIE_IGNORE_PERSTN		BIT(2)	/* 1: ignore PERST# */
A similar but earlier patch can be found here [1]

Link: https://lore.kernel.org/all/20260924-spacemit-k1-pcie-fix-v1-1-002b5c=
1ba9fc@linux.spacemit.com/ [1]

--=20
Troy Mitchell


--781b55b6c1a4b8d869ac8afe61faab8498bc4cbf4cf36fd0c52106658e40
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJcEABYKAD8WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCaus9tiEcdHJveS5taXRj
aGVsbEBsaW51eC5zcGFjZW1pdC5jb20ACgkQmAnvgPkzNC+1ewEAxnmEsrQaM6nt
GVmv86UInDT8zrl4WBXpVCs6pA5yKNAA/1T1X2kCyy7Yxg7Ot0fX/xJgCZje/tFS
dD2FLsLq/R0L
=hLW/
-----END PGP SIGNATURE-----

--781b55b6c1a4b8d869ac8afe61faab8498bc4cbf4cf36fd0c52106658e40--
