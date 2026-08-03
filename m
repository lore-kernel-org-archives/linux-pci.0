Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B4F347FFE;
	Mon,  3 Aug 2026 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796142; cv=none; b=BlGpyKaodbk+4Peia2Zp/Ad/K8BJpbEII3lJy+H1xFV8ZNta2Uwzj5uEN4x/WkjjNGobOe1qj1IXac0Ylm0b+HK96PdQ0/itDxRV1kqvaCQQLcomUdXlQG5qAcUmT7FQ0WZ6O0iQaqayj9Zdqczbc4RttRX97LmZYJNgx4B/l3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796142; c=relaxed/simple;
	bh=SSsQJxWFYPJRwZXkko3K9/YgsmEa2lDWeBeujXBL9a0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d97JEH/LR3hmQOhzXdYbGdHCn67Q6Za519D48uNqaS7tFo4ZR5+yFysRgNi6KnGGg8wIDjHv5KZnc558V4l0HolD3D8dTJIpobRqKFkGvQUs6mJUP/hghP96N3XR3MSwtquMVlMb3OJ7v1m/bd9AhbEv9SJyhL4VIYLse+dUQLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4/GGsuq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4/GGsuq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824121F000E9;
	Mon,  3 Aug 2026 22:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785796140;
	bh=SSsQJxWFYPJRwZXkko3K9/YgsmEa2lDWeBeujXBL9a0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F4/GGsuq08McxPew/0mxHt1wmKJmAQLAT5TOaDHjSDfZBhMOcwyTmJhjjE/abCmOH
	 4QWZSOzybuOGmX8tbl/jEB7Zxya7LmXYukTWUjsd6n5Wd6rEiv1RIaaqcB529m/Sc+
	 R+OkVyPRmo7QAGh6H/BS3mD/YPqlcyElQusr0wY3xbeU/HJtEJkVUMwcnqNabAmiOa
	 V/pzCWTNmNgo8NrVRSMMUWjeOKyJe7zaGK+Ax32U1G/V3QIt8OYJCJK+2Y5z30Rm/s
	 SyAqYLgVpcqkaYlxT0lngsRmaThLINMY3XNuWuSFNAyBTJiKRBIUEJKmlBBEv3L95d
	 ohC/fOVtnrr1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 06/14] PCI/AER: Introduce AER-CXL protocol error
 kfifo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260803221810.3685703-7-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-7-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:28:59 +0000
Message-Id: <20260803222900.824121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> CXL VH RAS handling requires a path for the AER driver to hand off CXL
> protocol errors to cxl_core for logging and recovery before PCIe AER
> recovery tears down the device. Introduce drivers/pci/pcie/aer_cxl_vh.c to
> implement this handoff via a kfifo-backed work item.
>=20
> Move is_aer_internal_error() into this new file. It identifies AER intern=
al
> error status bits across both correctable and uncorrectable severities.
>=20
> Introduce is_cxl_error() to gate the VH kfifo path.
>=20
> Introduce struct cxl_proto_err_work_data to carry the error source PCI
> device and severity through the kfifo.
>=20
> Introduce cxl_forward_error() to enqueue a CXL protocol error. A reference
> is taken on the PCI device; the consumer releases it via
> [ ... ]
> bridging code.
>=20
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803221810.3685=
703-1-terry.bowman@amd.com?part=3D6

