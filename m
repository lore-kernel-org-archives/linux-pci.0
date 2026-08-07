Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D5835CB60
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115764; cv=none; b=Dvh/4ErvY9Mn8KFmsLaAjDF5XTqWg8z23tFT+69bbpGMFu23tB8wL/+lajZt02VnTrF3PZbxixAnJ1ItsF3lWKqeOWPpObgbIWfPOoOJz5fbaVUBPmxKX/O37v4GgZXMsQxwjbBmR5nMO2P3jgzjMcqSFZOROVbcqGA7KQRCU3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115764; c=relaxed/simple;
	bh=KY0NEkj/Rulh+PD6YEpckuZvgjn4vcDmUDiCDW8ESgk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oXcMcO5KTMxXWtCCueCGSqzBFcZBDUfIGyHUcBoTKr6mP3f5mSUqHk6FukAoTIP37SI97b4D2wbBDVcf6QFjxlhsqHRQazmt77CIVhv8TtDpwUtFnxOO8SYi05awodxb+JCn0Y0vdUxwc+ewSk7piELYq3A6TwRkQ/KMRnMbYVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XprmG3oU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XprmG3oU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D961F00A3A;
	Fri,  7 Aug 2026 15:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786115763;
	bh=KY0NEkj/Rulh+PD6YEpckuZvgjn4vcDmUDiCDW8ESgk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XprmG3oUx2Hi8BB2y/Qz3UGzJ1leWIdTcdxWOIvO6OY2pqGnaUkdiCK0XHMNDfbpc
	 hrbWydjIYYC0KV5i8ss2YbLnjMnRgNN7CJAs+hSmRKZfDvn6jJETRMWyDlpvKNLUuY
	 dstvc0lLs0HwxT4e35niNMI7z3u5P1yC0QmxT0OvEZ8uW8vZdfik61NrjpDP75S5vV
	 z36GjH8LpofJpJQLhvBL1wOYZAsnlosm6MoGyPSesA20MGuonF+OKNTOPGb/oAzNJ7
	 +f4Trv4EYkGRja9EIhkn/UKkL0yAVAQJUvwQinTFL6xwk+RuC37n8lqyoU04QeZbxM
	 Mhj9lZP66mxyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 08/14] i3c: master: Support IBI-based wakeup
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-pci@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, Frank.Li@kernel.org, linux-i3c@lists.infradead.org
In-Reply-To: <20260807145638.168865-9-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
 <20260807145638.168865-9-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:16:01 +0000
Message-Id: <20260807151602.42D961F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> An I3C controller acts as a bus controller for one or more I3C devices.
> If the controller can wake the system in response to an In-Band
> Interrupt (IBI), then any device on that bus that is capable of
> generating IBIs can potentially be used as a wakeup source.
>=20
> Add an ibi_wakeup flag to struct i3c_master_controller so controller
> drivers can advertise support for IBI-based wakeup.
>=20
> If set, mark IBI-capable I3C devices as wakeup capable when they are
> registered, allowing wakeup management through the standard device
> wakeup framework.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807145638.1688=
65-1-adrian.hunter@intel.com?part=3D8

