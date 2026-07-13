Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1153955F0
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928795; cv=none; b=VrcICPGRmXHyTQrQjida3LpkmqyAdqq5OGJdYaswNp40tlS3Mng2Jok7myOFOcPpXckE+vuf2o7hwtTkOfW50HIgzhotU4sgpgBh9KDbCaYVnbCL1GrM5mXMcAs4JcALFC7G8inHcbw5aPSoyiKnfwnqnhEdgHlw/fkGCHjsGD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928795; c=relaxed/simple;
	bh=cMBiCrqMFIvfOtThQGGSmLiJHj2QYOlSAvN4SpjBKrA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tCcp8ueJ1BqOaUd/dtiK+XskJ9cKn1uP6q2CdDDLG7yI0HESnp7toEimjoM/0ccp5hPjBD0s5gM83MRtrTdcGG/QSR3LJKFHDGxws/w78AUeQ9p4Zy8EFiRLOzXdy24LOcVmOgDyn4ztUFDIwTV/B2l9AgdngKjll3tqq2M+sZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xmsqtedh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xmsqtedh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EB71F000E9;
	Mon, 13 Jul 2026 07:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783928793;
	bh=cMBiCrqMFIvfOtThQGGSmLiJHj2QYOlSAvN4SpjBKrA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xmsqtedh968V2BRzv6VgQQtMdtEjdRulacF/bRXhPSpkV2W77sOsqbnb5dXyms+G7
	 TR+m4q9D62VV3grcRMp//PFrEv/sJGdqPxdAsY0dPSjDFowe7XtSOHsAki6aq7i5Uc
	 k+08Z0WYz5Fy8aDwB3e0Ooryp1Ibdm175EdbJNNGP8Mz8tbcpF86NYineMs7VG5Zwy
	 wm/NpnrYExLY1ppQKmUDHVTvwUX8v3LD/hxJ9TlHxcSFrOFwmTK7CnD4hfZvgczaRC
	 8j4QN6zXZv/9WTmnZLeF985NOFbgEjWNti/neJXSH9qWlwOaQWy9A0rCCO7guuMpve
	 Ng7CkkVOFLb5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI: qcom: Rename qcom_pcie_set_slot_nccs() to
 qcom_pcie_set_slot_cap()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiang Yu" <qiang.yu@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260713-b4-clear_abp_0713-v2-1-4f0333a98d4e@oss.qualcomm.com>
References: <20260713-b4-clear_abp_0713-v2-0-4f0333a98d4e@oss.qualcomm.com>
 <20260713-b4-clear_abp_0713-v2-1-4f0333a98d4e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 07:46:33 +0000
Message-Id: <20260713074633.87EB71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> qcom_pcie_set_slot_nccs() currently only sets the NCCS field in the Slot
> Capabilities register. A following patch adds programming of another
> field in the same register, so rename the function to
> qcom_pcie_set_slot_cap() to reflect that it configures Slot Capabilities
> as a whole, not just NCCS.
>=20
> No functional change intended.
>=20
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-b4-clear_a=
bp_0713-v2-0-4f0333a98d4e@oss.qualcomm.com?part=3D1

