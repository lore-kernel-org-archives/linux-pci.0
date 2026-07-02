Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2842E8B82;
	Thu,  2 Jul 2026 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997192; cv=none; b=Iia002ca0QFdgMlusRlUH39w957WShvRJcpUQa4/huGdrcpBwAXW3I/037Ox2ryZTos90mp7AfEBV4gfljhm97D95AJ0lTj6bwDy8t6b1rQsu/jQcmks5jHbcPkheVc2ezIt1OcQ6UE2sF/D44sa3AxN/R1/7IZZwPxFZaCoHns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997192; c=relaxed/simple;
	bh=HACoyjBmaJjVlDkbsSFaiGHkqtlWJWIqijMpoW4TJDw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ohVeMoeg1JiDZR2uBHEhnoY96uOI9rWsZJIkdP/2pazhTRQXL4FTWW77aL0ECnShF3h3Pa0Hie1D3HRkTkYJ7DkksymkBVv7UXSttqcih1WnJtAqfbVZJ6Nt/w2LdJPy6ubDatK5CxChP6668vak78exq3nrPDh0m0ivTQDdCJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWhpWd2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWhpWd2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973631F000E9;
	Thu,  2 Jul 2026 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782997191;
	bh=HACoyjBmaJjVlDkbsSFaiGHkqtlWJWIqijMpoW4TJDw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HWhpWd2zA2rwnpXvrfj1YEXyyMNfgtj/JO9tiAo7ZVVcVw0cs14ALUwUdj9iAfqDB
	 fI3+c4yQyv+mHoEhu4hoAo6tK+yrDEns/CvWCYngv0CLBAKCRNemCaplphAIZRlhAN
	 Nu+8nN8zTzbHM7CFGTKIj92cXQTUfjB3wQwnKdVGaUWfSrg1u+9e96qlWSUHqkqOBL
	 hvbd+qusutRE9xphkvpZYdQvhLR+0HBVft2kLRMHaw5hsfWa2iTmgjJMm067/Tlp3O
	 0J25bRIR7SiQi05VnRqTh7uWaavVliy3l/Pb5mL6qLecQwWEflfsPSroI9GieLYlL3
	 DrJNSOYPAyPwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 18/18] vfio/pci: Expose tph_policy via debugfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260702124224.57168-19-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-19-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 12:59:51 +0000
Message-Id: <20260702125951.973631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add debugfs read-only file "tph_policy" to report per-device TPH policy
> value.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702124224.5716=
8-1-fengchengwen@huawei.com?part=3D18

