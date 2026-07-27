Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF07B416864;
	Mon, 27 Jul 2026 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167518; cv=none; b=sreZQRhj3K2WarBCOYQjAIO/1r14MQsUSfXqF5zOf7+bb1/uDdVkDC/C69SaVDdzuO0Pz679zRzUtUqNeCUOJko/VWJqw8xZsNoCSm/Qq3UpRedDDUZWz20WFbkBFdii4P6dSl8eIn1BneLFnXQYxReIz7qNMrkjcQKCD6eAFOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167518; c=relaxed/simple;
	bh=6Ta6Z9292MfchwvlfZlcj0Yb9OC8g0ZEmtjbsWn+1SM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q53bsNUb3cnDPtKYxfZ6wbRPPonZE3eRgJEtTiXv0yizuE6LSoD/6S40E3WM2TFCtA+rTQChndyU/Q+zki8deDMbtLIXgKk6NBE+8A3V1m98cCLxQdQVf9V2boIMIM/7UcuKr4dJzGknY5d7xsAMDn0o2ZRJoCJJt5F7jEts5DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAmkZhRF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAmkZhRF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2021F00A3D;
	Mon, 27 Jul 2026 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785167516;
	bh=6Ta6Z9292MfchwvlfZlcj0Yb9OC8g0ZEmtjbsWn+1SM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XAmkZhRFqLI75GngfE1qC1Sc5HTaEWP6ItjSzCra1T3o4ytEf5UBPkCG4UP/AtP3J
	 BELAeWY03UuBYSfTSuw3W27gt/vO94wsDgTFQ/JtMeGm75WUowsqWuH8RcKDyAsfTI
	 5qdr1GZ2iPn2gyAIRCT0evMchtz3lpvebMliEgn/XYKzjnGa9byPzhjgAveJopgWvF
	 rg/uf+qsCC0nsAx3agqPmirogFlj6/9sOMftHa74pNTez/rvkZk+z0Ha8vKTVFe1Za
	 qfZMAnWbaiF9Ak6EVy311/GkblvqtejhfRSEJjAUf/EgSzko0JzgPvkjKHRpkownjO
	 4yadBGAmIzRHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] power: sequencing: pwrseq-pcie-m2: add QCC2072
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rahul Samana" <rahul.samana@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-3-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-3-2d100f30e202@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 15:51:55 +0000
Message-Id: <20260727155156.1E2021F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>=20
> QCC2072 cards expose Bluetooth over the M.2 E-key UART pins. After the
> QCC2072 PCI function is enumerated, the M.2 power sequencing provider can
> create a Bluetooth serdev child using the documented qcom,qcc2072-bt
> compatible.
>=20
> Add the QCC2072 WLAN PCI device ID to the M.2 power sequencing match tabl=
e.
>=20
> This carries the QCC2072 M.2 pwrseq PCI ID previously posted by Krishna
> Chaitanya Chundru as part of the Eliza EVK PCIe/M.2 series.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>
> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-rb3-indust=
rial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com?part=3D3

