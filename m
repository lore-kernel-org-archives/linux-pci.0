Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57416393DF0;
	Mon, 27 Jul 2026 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167704; cv=none; b=EH0oimZEalRF+YGTX0mwmpJV8fVjbgDoZENEHLY5aNQpSxTU48CKc+S7LJKM4F9HIFScycCK12K/LaNwkbzDsbEzQWRovEJkmDUJi54O8Wj3IhOLXzuuHLFLXAsMfX2h7+dchY61/aSzuiDJ9NR97eOBKxIr4qnM7C1yzavxm+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167704; c=relaxed/simple;
	bh=oV9r0eQNB6FoJZMhdgXH5mQuQQVI/WS1lFCCSVKGgyA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lpk90h9IEKYxX9yqvuJLPCfXkmGSRs/HFErpDPIRryx1SqwOKC/NTiNBU0FziaPl6ZLi/g3L2SIwvMbuUajYW04Vmhi/eaBFPLrZ+KnvoLPH5xacGH29jEPqZGfwCvjeZhpqb8Sntme3yW8b/SfO3Bg/Fitxf0pR6/DHGaT177U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aij16AyB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aij16AyB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5FC1F000E9;
	Mon, 27 Jul 2026 15:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785167702;
	bh=oV9r0eQNB6FoJZMhdgXH5mQuQQVI/WS1lFCCSVKGgyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aij16AyB13Ea11RXxztYY3s5xBhBCT05nSVCznAHQJc3sLkZq4PxKGGfHrB0Mq/Oz
	 4vonEFbqQ2+T7VdibCd1lbZGgF6iawjY9FJce7ubl/yxt8DL1rFYxngrarC9WIqa5a
	 RJR3KTdQIvFfFWolmxkPvwk13ct6cwu7YAwxBWSU9l0k0fgfU2/nf+7FfATz0ih1hu
	 xZTdETScW0YaHU7axcZhY9Cpzx9BMlG4goJ+Nh6swtWZfVYz0XJOOPFCVJGYpP9XVB
	 8PZso1QV1ZHqMA8WF1tH8M0b3ywieO/tAPCtJFhnucrM5Qrf3hpS/VIEjJJJUMrW8d
	 cYwHuipN31j+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: bluetooth: qca: add QCC2072
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rahul Samana" <rahul.samana@oss.qualcomm.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-1-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-1-2d100f30e202@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 15:55:02 +0000
Message-Id: <20260727155502.AE5FC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> QCC2072 can be used on M.2 E-key cards where the card power resources are
> described by the pcie-m2-e-connector node. In that setup, the M.2 power
> sequencing provider creates the Bluetooth serdev child after matching the
> QCC2072 PCI function.
>=20
> Integrated non-M.2 designs need board-specific power resources. Document
> only the compatible for now and leave those properties to be added with
> matching driver support.
>=20
> Document the qcom,qcc2072-bt compatible used for QCC2072 Bluetooth
> controllers connected over UART.
>=20
> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-rb3-indust=
rial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com?part=3D1

