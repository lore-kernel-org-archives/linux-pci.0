Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FF640DB59;
	Wed, 14 Oct 2026 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979543; cv=none; b=nlxB7HIlGaBuPljSL4jc2frKIkDk8i4kcrehThYOfo36rUwkRtDYlrFZp+OI7mmNvNiSUIVmWbn/ZaUGBKLqk5RitkGsXK7VmY+vOyxdhMqHLWtw/nCU0ToxQAlx2YGItf2iB1hP/gtfm3LVrDpw/I4FjPgOJumJR43UmxCHruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979543; c=relaxed/simple;
	bh=fUVCnSYnvxi/5JLTXYWpn5RyhFC6X8/gX3b8ItAgdiU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b2TuMLlCaYmXt6xnU7qS0HfP6thFSdcwB/7n95XAXHqNll4Etan11c8kQNhK/ivwWN2K8Usaf3Q9xXpKqlTNotaTl7gtVerIdIFmW7ZJCSzD3dGn+40DwVczJsz5gte8cpgsfEE+I2yFEN4zpeJ+gtJl9Wt9UauSA98t5YqA49A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9DYpwfg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9DYpwfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B431F00898;
	Wed, 14 Oct 2026 12:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791979541;
	bh=UbWv/sKW2lmc17bvY7lmU1JjT4iCo+CxyyunhN+cEbE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=L9DYpwfgbq7A1hlSgGa4kKkf0hl6Smqwskhwsu5z+DMN9dKe1ORJgPJTRYNFZm7++
	 Gb1tQkmcgxUSOnPYajj+OeiFD6WOI6vfKX4iRGiol2OR5XnWtAAak66zNgBPvSJhCp
	 cB2rKk8t7RvStbddBaRD388k0zUZ25dERKumkjnbKWcqZzbCtrBjVFxhTSM35IW0VU
	 PwfxNc0LiM0HUV7A+3MIsjO1wFo5nPohOBRRwvq8yUBM/+4MeRffjCh3eI0T9L9yai
	 Q++241eGKFMY/AvzVDLfjtt9vsV8VQgFJo9Verk25TzvOt/FH0M9GWL3s80uO9annR
	 ddDV3jxbtyayA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, bcm-kernel-feedback-list@broadcom.com, 
 jim2101024@gmail.com, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
In-Reply-To: <20260911233541.1650895-1-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
Subject: Re: [PATCH 00/13] PCI: brcmstb: Stop using chip numbers for
 conditions
Message-Id: <179197952602.38040.4438252459530233972.b4-ty@b4>
Date: Wed, 14 Oct 2026 17:35:26 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1988;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=CRzzNPaNH9skV8gEC8csK/YI4PQjB9eAcSu5FdE1Hlo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqz3AMrN7UJ7vHZBhFsbIGNRwnoOkDmgY8rUVP6
 q/+oXcWx1WJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas9wDAAKCRBVnxHm/pHO
 9XlqB/9tGmBzMnCMnPGBUcutfz9p5JM2flP91QVH5egfoOyZpvXooGJTJ4C/sv45shkUFtIHPSh
 qCeSqFu1DEaFaFx+TqHjDm/DyBYVnhU4YbsdizJur864f4RzogtmLyAd3Zzjy+wfRTmBi0U/EXl
 ICqUXuxrUYYGty0HZOhUZlR0rH1p3wIYsLRE+T/xzhKjhAKpdD1X2q3VN4Tcch/Zh6GaqMhF3eF
 ER96d72vGJQBRVK2oq2jgfENaK0uxZXPSELptNT69COnqfDn2t8L/fEryAY+YdK4EXs++HVp0QP
 mNJLvXE4cbB9WFICfV2Ilv9DRdnv3uFE7o1qpURn/xwBJ7w+
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Fri, 11 Sep 2026 19:35:25 -0400, Jim Quinlan wrote:
> PCI: brcmstb: Stop using chip numbers for conditions
> 
> Much of the brcmstb PCIe driver code does (essentially) this:
> 
>         if (pcie->chip == 0x1234 || pcie->chip == 0x5678) {
>                 /* ... */
>         }
> 
> [...]

Applied, thanks!

[01/13] PCI: brcmstb: Remove redundant const specifier for struct fields
        commit: 46edf058e1531ceac70c59b0e69c3ff35b22e3f1
[02/13] PCI: brcmstb: Use flags u32 instead of bools
        commit: 17bf3521be9674ecdea6354af3ea2a38ca979ffa
[03/13] PCI: brcmstb: Add Broadcom quirks macro
        commit: ac87f644cec7f86681f56e2e07fb5124e622d26d
[04/13] PCI: brcmstb: Declare and assign quirk OB_WIN_32BIT_ADDR
        commit: 8f3d8492346ef55e20099eda7d170befcb2ad97d
[05/13] PCI: brcmstb: Declare and assign quirk OB_WIN_MAXSZ_128MB
        commit: 3c34e04a5ceb9f25453b51943127f3e242318a81
[06/13] PCI: brcmstb: Declare and assign flag IS_BMIPS
        commit: 19db283e770e9efbba6fcab0786210e4d870d7c0
[07/13] PCI: brcmstb: Declare and assign quirk 32BIT_PCI_OPS
        commit: 11c1752f24e643d7a3281f1add22f6a99d56a64a
[08/13] PCI: brcmstb: Declare and assign quirk NO_RGR1_TIMER
        commit: d3e27c1f1c1a3df58495f3cb51ce5ff0e6551256
[09/13] PCI: brcmstb: Declare and assign quirk EARLY_PERST_ASSERT
        commit: 644c94d347f644acf48801cd8841cea55e730bd9
[10/13] PCI: brcmstb: Declare and assign quirk PERST_PCIE_REV_CUTOFF
        commit: 1e840300326d6977cce6211e62e94022d569ac73
[11/13] PCI: brcmstb: Put max_burst_size setting in cfg_data
        commit: db776dbcfd25fc8e354aa4b3c16bdc4a7c59d99e
[12/13] PCI: brcmstb: Use order-0 indexing for inbound BAR window array
        commit: f22f415f21daaeb6d0e6b1537460513d3421d166
[13/13] PCI: brcmstb: Split up complicated function into two variants
        commit: f22895a0c371adaa8345dd76616462b868a8f38f

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


