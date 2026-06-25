Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5909436EAB0;
	Thu, 25 Jun 2026 20:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782420819; cv=none; b=UGCd1DWuVIYRo6X+0WhmWeYQD29avlIb85gASTTQerh9s4lKUlMvF5ySh2CHxZ5D1lGXpkDUFS35XlLn0iyLqaKYbzUGwj91SkBHyvJf84+GxUwWeuJyJkyAy4cKxr80rkacfy2BBU5i82ovIXKXfKg3oAx0PgYLeb3XhxMMVgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782420819; c=relaxed/simple;
	bh=MFEC6bI9J4i5Ri1jzG68eEsnbk9MiJyLXuEK6HfWo/c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uIabjHWFQVTVjp3ZoyZtRklJcxu25vbQ5WKqYB5RHFlWRqzcHMHD50arSg5dLFYSYAzxpViMU1TVyHrdABMsc4iMTBaEjkWouKpSq+L8/6xoq5XHI1C1iNZV+eYtdKSeSIuS5+usO2oKToHedmyif5gYEFRmu5yclFsm9T5bNX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bm0qzgHJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bm0qzgHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF21E1F00A3A;
	Thu, 25 Jun 2026 20:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782420818;
	bh=MFEC6bI9J4i5Ri1jzG68eEsnbk9MiJyLXuEK6HfWo/c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bm0qzgHJfNyMbb3+SWkerqrCfvs0yBfQNskDuMcqSZBGiAQTuNs8vrT5eNUioXRGH
	 wQfOH0NVx9vvOwssIVOimZrVpb2vIlGpOUja2sofn1UTiYCACSlw/wvFtN+NdUELeI
	 +bKOV8IR8SmI2lqzqdXdZOM6u7eUnCiqK8KCoNAHc/jbRUXq0va1Ft+TLuY20mkv25
	 nh4HwiZRQvdOZYR953MUcdi21oJE25JoPhr7l2IdilwCnSnNuHbFwkQ7WQLIiC1Ek/
	 MpnX4tgRC4MO/t70pTwkNfa5di1g50QO4i3OzeNZgnUvL95ub7naDqAxIis12G6mmG
	 nGdgqq+Hxy3xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: qcom: Document the Hawi PCIe
 Controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Leung" <matthew.leung@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260625-hawi-pcie-v4-1-1a578603cd86@oss.qualcomm.com>
References: <20260625-hawi-pcie-v4-0-1a578603cd86@oss.qualcomm.com>
 <20260625-hawi-pcie-v4-1-1a578603cd86@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 20:53:37 +0000
Message-Id: <20260625205337.BF21E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a dedicated schema for the PCIe controllers found on the Hawi
> platform.
>=20
> Signed-off-by: Matthew Leung <matthew.leung@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-hawi-pcie-=
v4-0-1a578603cd86@oss.qualcomm.com?part=3D1

