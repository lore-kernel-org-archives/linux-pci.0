Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964399;
	b=ZJYa6DJqlUkwHlb+lvN3MwuZ9Q8XgcyUXsYcdNV6SkrjnSaJzsKGgOSsRlO4az5NYHlf
	 HKbGdg54uUXoo8BMCScU0a4wjx7RtXlj4K8H/3oox4iAfQhXXfLXXBVUP/7kvq+tzJ07X
	 xcNg9h7w1lIgGLktdrbuIDZLkiA71Qadh9UmD+VciDQn451g4qSUBaH20bkioMLjWJKxG
	 0mlbiGizDUA+vzbGFUnWOq+BaH06fcYEGrdBQd6wEEsyfyHSPUguwvFW/EWaPrq2jB0od
	 n32AssvYAy+1SQ/gFUWbqZNKFAS//XJCEHtynqmMUymSJPtmZh6JkbsGJD9/IMNkNBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964399;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FC/u+mRrCqEQFOcuFmAJe/OYhfJsDrAb8u9CpOHUplg=;
	b=yTTcZFcrJvhLOFHXnqDepTGSJjt8ZziV3ADCC6QXrR/+ijnzXMAgofxeZj/hGJhcbcqc
	 ntXavMhQ7U2c8mp54YoxSvAwDCPKp/0MlG0SqdP3oVf7vxTKooIj8eXvqOROFO/5Z9Pk8
	 0tk0TcM7Kox9hjbsFHHEadtxwAOijuyfKBMLzxA5ca3WdtywkULPYCfBQy8RDxdXMEGrT
	 WKRoCM3ISCU4ppyNMl/uwsx82CCEcReQbcjONPZIBPB2wD5CTvxdMJZ42VYb0HW4raLEo
	 /ql5FCGIbrAA0sSNPCqDSGM8ERfOY7wFpfre+GUPwjbnndnqGEMVM7U3QJDDBgnUw5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gF8Aytqr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F28C606A326
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gF8Aytqr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBB91F00902;
	Fri,  6 Nov 2026 11:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793964398;
	bh=FC/u+mRrCqEQFOcuFmAJe/OYhfJsDrAb8u9CpOHUplg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gF8AytqryolYodZstDcg3Q7S8heD1NP/c63UJnyxEYNtXG6pnjWPcO1HtrIgtAYdD
	 wLYV4JMRs/c8u6VF2TyD4qLUlP/B6h7opEkxj50SFNfOd3B6gQLZIqsKq+MKKGN5mm
	 CKxuRujMSC7Oo441iHzDPRnKRIsGgR/mnIRafDNk7L4ZscZ72p3qjx2PwNAP8LTniN
	 SHI3Raqb1i/7q/lW2QmTa10rjUNMg8AgvULP8YdbDmRcKNCg+XOzuPh3DThOoBeNWv
	 l8wg/vcjUU7XtivxNuMqcWeZXp8mr6JGzOOEb1VVGdTH3JCFgVCfXK/ozSL5LNSTnG
	 aypHr/RBGpCuw==
Message-ID: <sashiko-outbox-201312@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] power: sequencing: pcie-m2: stop requiring
 subsystem IDs for WCN6855/WCN7850
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261106-pwrseq-bt-subsystem-v1-1-11fb09f63c93@oldschoolsolutions.biz>
References: <20261106-pwrseq-bt-subsystem-v1-1-11fb09f63c93@oldschoolsolutions.biz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:26:38 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] pwrseq: pcie-m2: bare PCI_DEVICE() creates bogus serdev on
  USB-BT cards
--

commit 651d16502b81077112cba212f5fb84dc03306321
Author: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

power: sequencing: pcie-m2: stop requiring subsystem IDs for WCN6855/WCN7850

This commit replaces the subsystem-specific PCI_DEVICE_SUB() entries for
Qualcomm WCN6855 (0x1103) and WCN7850 (0x1107) in pwrseq_m2_pci_ids[] with
bare PCI_DEVICE() entries.

> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/se=
quencing/pwrseq-pcie-m2.c
> index 56c5d51293c10..72c721149dfae 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -217,15 +217,9 @@ static const struct pci_device_id pwrseq_m2_pci_ids[=
] =3D {
>  	  .driver_data =3D (kernel_ulong_t)"nxp,88w8987-bt" },
>  	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x0108=
),
>  	  .driver_data =3D (kernel_ulong_t)"qcom,qca2066-bt" },
> -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_FOXCONN, 0xe=
105),
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
>  	  .driver_data =3D (kernel_ulong_t)"qcom,wcn6855-bt" },
> -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x337e=
),
> -	  .driver_data =3D (kernel_ulong_t)"qcom,wcn6855-bt" },
> -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_QCOM, 0x337c=
),
> -	  .driver_data =3D (kernel_ulong_t)"qcom,wcn7850-bt" },
> -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_LENOVO, 0xe0=
e9),
> -	  .driver_data =3D (kernel_ulong_t)"qcom,wcn7850-bt" },
> -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_FOXCONN, 0xe=
0ee),
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
>  	  .driver_data =3D (kernel_ulong_t)"qcom,wcn7850-bt" },
>  	{ } /* Sentinel */
>  };

[Severity: High]
Won't matching bare 0x1103 and 0x1107 device IDs reintroduce the regression
fixed by a39ac4651e3b ("power: sequencing: pcie-m2: Match WCN6855 and
WCN7851 UART BT variants by subdevice ID") whenever a USB-BT M.2 card is
plugged into a socketed M.2 Key E slot?

The pcie-m2-e-connector node describes the physical M.2 slot wiring on the
host board, not the card installed in it.  Boards with a general-purpose M.2
Key E socket (such as arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts) wire the
SoC UART to the slot and define port@3 unconditionally in their static DT.

When a USB-BT WCN6855 or WCN7850/WCN7851 card is inserted into such a slot,
pwrseq_pcie_m2_create_serdev() -> pwrseq_pcie_m2_create_serdev_one() sees
port@3 on ctx->dev and matches 0x1103 or 0x1107 in pwrseq_m2_pci_ids[].  It
then creates a bogus bluetooth OF node and UART serdev device, causing
hci_qca to bind alongside btusb and fail with -ETIMEDOUT in qca_setup() on
the unconnected UART lines.

Also, the commit message notes that Lenovo T14s Gen 6 (17aa:e0e9) is missing
from the table, but 58a003302481 ("power: sequencing: pcie-m2: Add Lenovo
ThinkPad T14s gen6 WCN7850 subsystem PCI ids") already added that entry
above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-pwrseq-bt-=
subsystem-v1-1-11fb09f63c93@oldschoolsolutions.biz?part=3D1
