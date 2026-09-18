Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44623090C2;
	Fri, 18 Sep 2026 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745489; cv=none; b=s1tePL0nwV2uYXkmg3ZzzD0g1JmGgPZg4QyC3+0+RxmQvvJn8E/UT31femCZc6wlpuwNRRdWJ52BvSgIrdngLLZfqcxLAInQWhfp/b9F7cDYq2OMGpXYK7ebzlRvWGvYunkIA+HIoYu4grSnYiRlKmmRtC3hLVL0cfEd7xTSJmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745489; c=relaxed/simple;
	bh=jp9qDBJF3darrkYbzmxfArfYzIxW8dGo4fwliq2Rs5c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YbBboBnGAE08c48soHEAIP/RjlbnCwLwKiOOUJ7CNt1r1+maEDmOQARLiTm/zA79Ho2rez8JPS2+PWzHQwRBVedauwZuIM1ug+tUDBO6UDHLwszMVtEXY/dqskwlPr1GXubbA/jLfF6MYaHRZ+l5M2v1x/3rqakIsUBmxOJS5Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD4Z5/Ja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD4Z5/Ja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086E01F000FF;
	Fri, 18 Sep 2026 15:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789745488;
	bh=yM3fVcIx+fEER5/IfwcB6gXKI+kXTv+gpXaOiFjw78U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WD4Z5/Ja7pcCN70u0iQRKlt4eiqFxWcKWg5D+WCE3ZyemxdP9aeA2eZlPvBkiB3b8
	 1mI1p1jmzKh/gqR1nrRaEZqClXemc76Jx0fOWx5qe992Ppddqa1oRfTSr54Da/pfVb
	 T3JcAOSuShV960UwTbFklGgq3TiK0aW7wbiyJQTpJ6Z3t3yKl9QXRu7RFG30e87wK5
	 1H4xL43xUBjfQIxiXA8VnJqApjVaQPSqOmbsmSsE1YXY6RGG5xZ1e/8/o3rYQm6G+V
	 M7/EJJZ0tjno1czk32Mx8FnFhdlKuCghpScnpXpAHPOx9SmlHhbGsCtmzPKuo8nePh
	 +egb9NaX8nj0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: misc: introduce pci1179,0220.yaml
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260918152659.413268-2-elder@riscstar.com>
References: <20260918152659.413268-1-elder@riscstar.com>
 <20260918152659.413268-2-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:31:27 +0000
Message-Id: <20260918153128.086E01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Define the binding for the Toshiba TC9564 PCI endpoint function device.
> The third downstream PCIe switch port within this chip has an embedded
> PCIe controller, and that implements two of these PCIe functions.
>=20
> Multiple internal components are accessed via PCI function BARs, as
> indicated in the diagram below.  This is facilitated by the use of the
> devicetree pci-ep-bus mechanism, and is demonstrated in the example.
>=20
> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918152659.4132=
68-1-elder@riscstar.com?part=3D1

