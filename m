Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793431914;
	b=E/aWatNriaRGNBfbK+NdCqzeR4mSSYZMD+AzS1dvSI1qOh0hsSxjUWkV/Quy7acKl0EN
	 o9cbS9dUL5J9utuGUQat9Wp0Z1Xg6mVvw73/JHKlfb99tlWl1UfyPu+YVgqYhYsN+4MwS
	 wmxKeK0iSaaKkwnB70JrujUitJYWIVlIIktCZjgjtrbUlj+D3DonGKVZm8EFMOYUAuYlA
	 /NPQ1XrP3IbzAF2qVUJijvtPDQHAq2Hh/CroT85efYxpEFVls/JwpnTUwyM0iRp4Iq6Ng
	 Uop+EAARQ/83jA3OOvyoNPu52xFpHVKg0aqGyBNoMFO2Cy/je/hJuHoKmbLqVvY784A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793431914;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dQj9qlGpCzYAN3rygzqr317OiXof6DUeRrNCcXT9mSQ=;
	b=EvBi20MmKK7/keHmI9D+gWfkbomYOGoMFUpFPZCuKyCQcc7LI6Z72Vzg8oDEYz1smA1c
	 XGVdg9Abm//DnoScSQc46ML/4uqPRf2ddOnA4HN12Uu0iBrvuKEM49+5QMRNY8Fl7VERW
	 fmRvtrNM1ZMRNCKD+E9/iH+q16D/FFyauBS3SzTVTa7MXGCzJ4gT+/ZGKiAYasZOCyWVy
	 uG/CKdWTWfkkLM5cuxRUNf5K7t8sUVen5tFUodB+STY8Ym3DzKgI0jFrLLOtav1/TCpK0
	 otdov+/l2QumqP2McA0qA1W29DkjvnFsLws8T4QL2s0KsbU4h1ldV1tCHFGSM/44ARg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBoYoN0y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93657606A31A;
	Sat, 31 Oct 2026 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBoYoN0y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129451F000C1;
	Sat, 31 Oct 2026 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793431914;
	bh=dQj9qlGpCzYAN3rygzqr317OiXof6DUeRrNCcXT9mSQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OBoYoN0yEyiCXuwu68V99mbHyW27eFY8oHjsuiTzzRVuAqQ3R6SNZdHug2mWOi1Z9
	 Ay9/uSFELqulgJIbl0FUmjMzknTFpZ9q8+gUxsgRtzjoDjLZqjkcBIBLy34kjdZHKE
	 /bKxll9XuGgusKw2nBaHtxADC8tl68aw64uBac4stZxAb/2wwJ0eQKucEL5zQzIYsh
	 3FWax4uuW2jgtJ15gxmi0S6HID4N0eWWKCIz1faFZiNJYavD7+GEnz7xRmPy/IuhA+
	 RjnelUPQu5vA9OuCPRD9MnbRmO6ng8fHwPWHq5j3N1n0x7A1tWY3Qxj7AnNf90+fGX
	 Gl6uzFdSFDQrg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Niklas Cassel <cassel@kernel.org>, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Jia Wang <wangjia@ultrarisc.com>, Xincheng Ji <jixincheng@ultrarisc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261020-dw-pci-fix-v2-1-32b6d62e0edf@ultrarisc.com>
References: <20261020-dw-pci-fix-v2-1-32b6d62e0edf@ultrarisc.com>
Subject: Re: [PATCH v2] PCI: dwc: Skip MEM outbound iATU setup for identity
 mappings
Message-Id: <179343189306.4244.9558633499396573054.b4-ty@b4>
Date: Sat, 31 Oct 2026 13:01:33 +0530
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=342;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Qdod0boIAF5HAvXB4OJcFQ8RnilFj7Ah4qcH+RqVTqg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq5Zlk2CIKVrdXiej6yqB5UBJNS+vUmoZ7tAfkt
 cRln4coeHqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauWZZAAKCRBVnxHm/pHO
 9Y4QB/96bfhgNHg2Yl5oRL1JufTvVZvCRcBzTttLV1iAvR4UOcGhZtWyIX9bdp0wSrPz5ReVNF0
 U8+ft6hdPxgOZKWm8SBCeYP96+e1WkXK7XD9WYiFJ5tf3eFTeeu7gTGgvDmAOSLIao1ZH4yzDPE
 kfPmP7kAUhQucsCdT/PYMrrNIyooc2ozNYE09RHcj821Bhv0CusAvAirTjsztxsNVkexF3YIHQ0
 b3D4jMHxLlCa0THkS//yekKWwQVE9ttmFZiqHGTXi+cHnCR0C0wSfNMn+ynVkzLk9h2riCJAT5N
 TOi8YYyAOZTs3wpt+8+hv78mAYztjlOiZRdf9ZeRBQzEOICs
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Tue, 20 Oct 2026 10:37:35 +0800, Xincheng Ji wrote:
> PCI: dwc: Skip MEM outbound iATU setup for identity mappings

Applied, thanks!

[1/1] PCI: dwc: Skip MEM outbound iATU setup for identity mappings
      commit: 8b0e01d77ef4ceedd96d00d28f3518037481d2cd

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


