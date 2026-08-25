Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E6F285CBA;
	Tue, 25 Aug 2026 02:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787625478; cv=none; b=sIXhHn/ozXL3Om5LIx6skTLXnrcNkR0zZWnlrS3GNVNl/Ig7Dsdr7E0cxaGBb0qc08WEkG7HBKNlUHRZ2d/m6JNRBmKUXJArBA1WKEnKHJwukHan03ExiXyvhAjoMU2qS3xCX+0Ef+fodelg8uIAnkLIlgwahwYLsXwP1KOmVaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787625478; c=relaxed/simple;
	bh=YvPgjaWVYaZfVW/0lH7zGts1VKsa6DVEor+RY99CYFc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z2HQIk7/DJh5i1ND35XnPZn70uWMt7lin6mngVY3Jz62TDKnVuDVqw8TEskkCMwM4mLzesFVLY8TQ3IpFXXXhTINwsA/co4ax3/i8NNsQ3eLWIdO6//QxWp9hZapCSaGw807Bvarelcxd4069kLlGPsAfjqZbQuKLnxBIWZlMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/c/t9FH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/c/t9FH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63DD1F000E9;
	Tue, 25 Aug 2026 02:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787625476;
	bh=YvPgjaWVYaZfVW/0lH7zGts1VKsa6DVEor+RY99CYFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J/c/t9FHVK0QRJsVe06uphZdwQ4xegDrUxweafvUyhCkGAkkDegDhB7tgIms5Obzm
	 wQnHQIzDfDSoUB2XqoSWbPrRiW/flRxC9mqAGt6QH5uk9Tq+l0RugROjEIgKgxje1U
	 K04/UmOGi5qY2IsSBwmej2UKNI1RT//BIHBJmRyJRqa7QjR72o7kbmhXjBli1D8rVY
	 rrCCqGn9o0YukFPDyHuQ4TUUCER5bSG73fcVFG58bcIp+YOt+LeQNnfoo9mbmDcgDD
	 z6UNj5YOFjvWlVUjWS1LwF3eXbQYeMBglSBWmCKXp+04kerqKE6EPud0PGHNd2oyL2
	 o1pLRL0tsAMmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/13] cxl/pci: Make the HDM and Mem_Enable writes
 callable from CXL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260825022628.3651434-2-fabio.m.de.francesco@linux.intel.com>
References: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
 <20260825022628.3651434-2-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 02:37:55 +0000
Message-Id: <20260825023755.D63DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Split the Global Control write out of devm_cxl_enable_hdm() as
> cxl_enable_hdm() and drop the static from cxl_set_mem_enable(), so both
> are reachable from the rest of cxl_core. Declare them in core.h.
>=20
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.co=
m>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825022628.3651=
434-1-fabio.m.de.francesco@linux.intel.com?part=3D1

