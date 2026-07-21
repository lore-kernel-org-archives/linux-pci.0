Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E76610F1
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 02:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599630; cv=none; b=guVBN2OangharZ+jd0ztU8m5nDf9aSI1nLAWN961PbqkxvvJ3HnsJhoPZzSKfCRZsE4qefiI35vy7Zq2bDnFZJXvb0NOBVdalLYiF+nMFLibJ1a+AR89I0Hur0jHD3RqSkNPTQ59DMkJRu6ly8up3KhhxioVApGAsYUrTVesvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599630; c=relaxed/simple;
	bh=p0JPqYGx+3/10Z4GNIBSMhItqVIWKC39yJOgebrAIj4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r5gu/4UJYwidTQPLc3r5tnp08pUEesQryGaCP9DS1sO07LHNx7on5Z4eWvXJRJsmBuQy+/ei1w1+Xkqly54A03PYFAkq1msaFNpl0/NviNCQw6S/vrtf5SvOgmAGCWKHObszbZ3agEhdWIHK8sEWn0/b5UzCUWajvcDx07RLnmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOKkxd2E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOKkxd2E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E361F000E9;
	Tue, 21 Jul 2026 02:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784599628;
	bh=gpOmaLUqi1B8XzA2C4TeWYP6fPmVD9yXRuJdK3wFoIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FOKkxd2E41uUdpq4868HR2nI5Q5wLwh60MYFsxkut+eR+6bO3V/kD/uTnIWZFOH6/
	 H9kkNBUUDmbZygUsrKArA5N3j5qiwv7sP/8kufV8Lf8jP90xIhs4INX505eTtEMj+3
	 haUQKJ4hHxJDdeWenjkCwT0HBQiynH2TqLG/prIo7wkWjqfwoUlwiOEQmf845iEakA
	 QZpfoLwusI7J0440oRettYjb/eB/rnIWRHbHA9CjNr7rXcmo4/QZ8TMQzVpWxjTQw4
	 1tovBfGKArzoMW6EN03YD6siAFbJjUZM/VmC0rHs74m648H4HtHxqlBI/xVMnGT5lJ
	 SCNiDQIP4sbAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] alpha/PCI: Make the suffix the first
 __pci_dev_resource_attr() parameter
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260721020427.1541197-3-kwilczynski@kernel.org>
References: <20260721020427.1541197-1-kwilczynski@kernel.org>
 <20260721020427.1541197-3-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 02:07:08 +0000
Message-Id: <20260721020708.A5E361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, the __pci_dev_resource_attr() helper macro takes the
> attribute name suffix as its third parameter, even though the suffix is
> what distinguishes the three attribute variants built on top of it.
>=20
> Additionally, the pci_dev_resource_attr() wrapper passes an empty
> suffix, and with the suffix placed in the middle of the parameter list
> its invocation contains two consecutive commas, which checkpatch.pl
> highlights, as follows:
>=20
>   ERROR: space required after that ',' (ctx:VxO)
>=20
> Thus, move the suffix to the front so that the variant selector comes
> first and the empty argument follows the opening parenthesis, which
> checkpatch.pl does not complain about.  This also matches the parameter
> order used by the PCI legacy I/O and memory attribute macros introduced
> in a subsequent change.
>=20
> No functional changes intended.
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721020427.1541=
197-1-kwilczynski@kernel.org?part=3D2

