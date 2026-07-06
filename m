Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AE8233721;
	Mon,  6 Jul 2026 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332325; cv=none; b=W7YCTgel2t4hecnrLv0ikSfWdf+7hJNZoPk3C5RFNd4oqunLJ/5lyxtqgCCMuzXQwIXd6c58CNuUu8MbqWmGC/fliL4q46J640gnicaKzMQWBAr1DR5vwEuDV5OB40LW8vS3q4pog4vlvxuKOu+NCrslsNd6TP9tftwPQLiKVTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332325; c=relaxed/simple;
	bh=jZ/jeF0rqeGJmOgvFJLDOcdQYLBkfprGmEHK/lqf0cU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZNsdbUShh1mnzhAQlxlX7c65H9BxLHQ1pasDfBpgQPeW9huxjZ2OV9jqj7l8zHY8dBaYnam4xygxZBaBWeCeSAH80KBkVZQTInVc4168+TafPXNqsI5hgl2j9mYmNVdTYATB4BndMlPfB16WkrqFw/6C6BhlV7uxbg+w740IWrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuQ5N5rR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuQ5N5rR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93261F000E9;
	Mon,  6 Jul 2026 10:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783332324;
	bh=jZ/jeF0rqeGJmOgvFJLDOcdQYLBkfprGmEHK/lqf0cU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NuQ5N5rRf5wDjZWeTuWo+tq6OFFvFIUw7G9pFQRGMnRxzDTumlAnNBJG7dCYyrnb1
	 CMW5tXlEWVgnd8wbzuU94PWub8u86BC/Y7oipzVoMvxs5FGQLIYUzhDPTbbpqin+6K
	 xD1aoyUi3dYZvh80NYvgzusCALBlhfsx95fhFQNEvN60/I5cXhXoHxAbHg/a4nQiRQ
	 UM3XHUCjr1xl4sRaGz5azo2Kpw3eRJ0nOZN/qTL2RznWdiI1yEDcaQPLgu1psCjp33
	 iF9GWgTmpuY0MCVyTpxaUjAzv6qa7t7PeSPYtZtfpds0MhUaDKHaB46KSH5G2q1hgp
	 lhMPRZgc4bTpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: pci: ultrarisc: add required DP1000
 PCIe clocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Wang" <wangjia@ultrarisc.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260706-ultrarisc-pci-clk-v2-1-2f3fb6fba66b@ultrarisc.com>
References: <20260706-ultrarisc-pci-clk-v2-0-2f3fb6fba66b@ultrarisc.com>
 <20260706-ultrarisc-pci-clk-v2-1-2f3fb6fba66b@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:05:23 +0000
Message-Id: <20260706100523.E93261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Jia Wang <wangjia@ultrarisc.com>
>=20
> Require the DP1000 PCIe controller nodes to provide clocks and
> clock-names, using the standard DesignWare clock names "core",
> "dbi", and "aux".
>=20
> Fixes: d9ff07f45955 ("dt-bindings: PCI: Add UltraRISC DP1000 PCIe control=
ler")
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-ultrarisc-=
pci-clk-v2-0-2f3fb6fba66b@ultrarisc.com?part=3D1

