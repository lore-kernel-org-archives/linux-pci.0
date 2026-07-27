Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FB53EDAA3;
	Mon, 27 Jul 2026 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167447; cv=none; b=uv3zjiP+gpYcxOc38qDeFjCpAjKr0v7bVsgJIx1Z9MeSn9hMyij7Vjf17wJjKaK/+lB9ksfcHytykCt3tLyQfbUYRG6lT3hizflDHcIYvxWmFJEnNKk61IPzzdT68gZXHQlqvNmevOFrhSPhL7JmafLB5b5GyZU5sozDiw2hVC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167447; c=relaxed/simple;
	bh=Lk/XpKv5ZZhmtce8SV3BnANjnhLu8AuXgzvzd6uLm5A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZJEKY0mcwS4Wah/47VZbXLjpMpANLNOO18216MPQb5TCfhXODIERM8mRoQHMhd47IAoBySQamUxmr28BaEV5xQAWVjOv+tR6u1DfEQss2LtTERJRN3UYpx+U7ajAJtSx/26A+y1U4U0TNemh10WGaxXyEN9vqpLD2Ms/P0Pl/hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCrszz01; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCrszz01"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F921F000E9;
	Mon, 27 Jul 2026 15:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785167443;
	bh=Lk/XpKv5ZZhmtce8SV3BnANjnhLu8AuXgzvzd6uLm5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bCrszz01hehT7ZMpNV+bs1+akgNEjSdb84fMMahvWGYQJpP1VrLWBroNlc9K3DpLn
	 tq6jtGq+SnCpIxROT0nSykpEAGjALSfeNllwdr588MrrP5qu1jNRilzaIFnEYaAdmD
	 3xGleCoDw6w1mOPLfjZL5B1HJHf4kQVxXqNpe5a2+7FGZeFOrQnZlDSjRHeQvGL+z9
	 0DLCHUox0BP6RetgpJPz7NCLH/AXg561Z+vQRqsSx+hMGWgnlPSIF+sbuiX5UOA7A3
	 qrQIv9OtgfTN5jKvfToBXQTvkmHHvMQXT/rwKM9RLgd/hpB0sK6RxupiuG8+Ap0ZP4
	 3/RQaim7BY91g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: qcs6490-rb3gen2: label BT PMU
 and M.2 PCI node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rahul Samana" <rahul.samana@oss.qualcomm.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-4-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-4-2d100f30e202@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 15:50:42 +0000
Message-Id: <20260727155042.B0F921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The reworked RB3 Gen 2 Industrial BT UART overlay needs to disable the
> on-board WCN6750 PMU and add a graph endpoint to the M.2 PCI node.
>=20
> Label the exact WCN6750 PMU node and PCI child node connected to the M.2
> E-key slot so the overlay can patch them directly instead of using a full
> path or reconstructing the nested PCI hierarchy.
>=20
> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-rb3-indust=
rial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com?part=3D4

