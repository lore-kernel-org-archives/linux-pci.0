Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826FC31197C;
	Mon,  7 Sep 2026 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786558; cv=none; b=tqabGZEhuq13xg7KutehgK2X2zlzGAGWn6Jc2dqoa403o5730TUJ04r8fXwBmtJMx1hUgOCzxbJeHWjYdKy5z4Q7lxcQGF9+V7mgceEJE+JnsYKEnS4OObRK7yqqAt55OEiluvBRK+hZbdFXYXWlrSZeKDHI5m+nZuQAKhT8zog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786558; c=relaxed/simple;
	bh=/o9/t0rmsd+fDXAPn0EGWSuuwiBMQU0cSgC7TC+ItGs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 In-Reply-To:References; b=JrClLGDB543KlDCTIph7GQO8ZVVlSLF2u1njwFcG+DaFRgpFPHIOBC5xyuUuzAUNG6/IAs2/EpjKPyrYBMKIdkKaA3ZTVC6oXZuyL6hiTcNjSvlUale4oo8D4wakUFrOYD50KPzIATKumGCbKQ8Qqbk34/kyuhWPppcfAlkgOsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=l3mgh9Fw; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="l3mgh9Fw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1788786517;
	bh=pfKIQsbo9vF3XKUv7eH674e4/SPUP9mmFk38JxN5/+E=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=l3mgh9FwALlTah5zOJpypOJ3uMMBBc8FN0PS6a/mERDu8FSLvDif7/c+QSWEuwEq7
	 +c9gRjyECkiHC/wdfTOUHUQnIVWUE75zZYR8iREMZIkNbEa8VzBixx7tIRJvgpa2R0
	 p0F5ty2IDMyzVMyJIEhso6rIxvhj5ud7qExirEKs=
X-QQ-mid: zesmtpgz9t1788786514t356b3c3e
X-QQ-Originating-IP: 4bNg8jVrPAYnd+pOgZsuQP2LrmvmE3yfNAvXm2ENHLQ=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 07 Sep 2026 21:08:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11280198482771072461
EX-QQ-RecipientCnt: 41
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=650bf3549e64181e01b13e7f3b0c8c6526d5423fd2d0620ee7d870eb7180;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 07 Sep 2026 21:08:28 +0800
Message-Id: <DL93W9G65JL4.SW643T11BP8O@linux.spacemit.com>
Cc: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, "Yixun Lan" <dlan@gentoo.org>, "Longbin Li"
 <looong.bin@gmail.com>, "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v5 5/6] dt-bindings: PCI: spacemit: Introduce Spacemit
 K3 PCIe host controller
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Inochi Amaoto" <inochiama@gmail.com>, "Jingoo Han"
 <jingoohan1@gmail.com>, "Manivannan Sadhasivam" <mani@kernel.org>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Yixun Lan" <dlan@kernel.org>, "Paul
 Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Frank Li"
 <Frank.Li@nxp.com>, "Niklas Cassel" <cassel@kernel.org>, "Sherry Sun"
 <sherry.sun@nxp.com>, "Arnd Bergmann" <arnd@arndb.de>, "Christian Bruel"
 <christian.bruel@foss.st.com>, "Krishna Chaitanya Chundru"
 <krishna.chundru@oss.qualcomm.com>, "Senchuan Zhang"
 <zhangsenchuan@eswincomputing.com>, "Alex Elder" <elder@riscstar.com>,
 "Xincheng Zhang" <zhangxincheng@ultrarisc.com>, "Randolph Lin"
 <randolph@andestech.com>, "Siddharth Vadapalli" <s-vadapalli@ti.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, "Vidya Sagar"
 <vidyas@nvidia.com>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Danilo
 Krummrich" <dakr@kernel.org>,
 =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
 <u.kleine-koenig@baylibre.com>, "Pengpeng Hou" <pengpeng@iscas.ac.cn>,
 "Anirudh Srinivasan" <asrinivasan@oss.tenstorrent.com>, "Gustavo Pimentel"
 <gustavo.pimentel@synopsys.com>
In-Reply-To: <20260907112606.465778-6-inochiama@gmail.com>
References: <20260907112606.465778-1-inochiama@gmail.com>
 <20260907112606.465778-6-inochiama@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NZcrde3zhHkVEfBIs3uijfG3JeRbhBq3UmJylEptFf0SpLLWdZHy7Ot0
	ZdrWOeHEzdThDcXv5zV3qL8m9nubSaA4PMjERuDye9Pwl18vZKWliluD3v4PoyFXUNpB1cG
	wCobNOSmmwGrVFIGEoOVWYIlCSNboCG01PEpsJlxkI6wSRESTwfgVCfxd91wIWa9waZiI1v
	iQ7iIp+YaOllGQIhwbJEVIvWUUX3Li82zr1xG9UCEC6LV9jN3h6ypdtx1Rl0Qyw4NOhFIwz
	EUy1lKyNza2sTL1PjXch136CShXCFXRW6z+ELzeem5rTa0hmmtccxotvCPqFLPfM+SCZNRI
	YAKUrqJKIL0r7M/E2AgtOVl2wy3/h9gAzadmb6S8BLKgvC0EYEopoqPCxeKQsqgmWNeW8u3
	Pbvrwm/jVjBgRgolhzzTj5ZDj/dwcyj6Hg/7O0QGEFfDUjuiWz2t8LgnLMPI6QKyYHf6swz
	DrPuEIPxmZVA4g1RBnQ5iw5sqjwWUx7kSBzO+DsyL7Mpk3jO67pxVkc7NozN4cZY0fQV4nk
	VhKzHSwgkpUNeJZ7tZTtGWj5qppTgHJvt4Zmqc0rNa0DxAp0ik0Haa187asxSpPDMJiOJyn
	2m2+iEHaxCtx81hmh5f7nJN1T0brRHjhNfW8gvzMkGBSDyE08zqIWtTEDs5lBNwu9pHo8PX
	Ta8fm6vm4snKTFwz5TscETaFsm5H8SVKErqHAkXbKKPerNHVb0C1tU1Qbpg6LZ/UG28EPzF
	8doJbQMfQ4IdH/CSI6Sxw4OAfWRk0Wq5FZ2rx6awC1YMOq7rrtq4bA2lZN7jdAwCZzskuqK
	S8ePmsFLMzXr44f6jV9K78r2EFJv31tMATbM40Vaf9oK7M6anrvUrtGU0GEebC5LJjFN+OG
	xEgec1pPYyBpjFXMOkKimV50IKBB/wEASWZRHE2SK1WJDS8B5ACVjn/ybSWV6LZJ2QxE6zV
	RwZr0Xihs60COUgOz2W2Nz0eFkFWXPtUfHx6QcpIjYP/dGGVfKddmSrwQkcePrs0UmBTFdB
	wAmMdpnaHktt/1rQO+nYRVN2xBzmoXy4+eyxQuKgtZi7hEF7Fs8VQ5HolxQfBV4jFitqdYk
	lMVIxWCW4PMQwcy3UFxIYg=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

--650bf3549e64181e01b13e7f3b0c8c6526d5423fd2d0620ee7d870eb7180
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon, Sep 7, 2026 at 07:26:04PM +0800, Inochi Amaoto wrote:
> @@ -14,26 +14,29 @@ description: >
>    PCIe IP.  The controller uses the DesignWare built-in MSI interrupt
>    controller, and supports 256 MSIs.
> =20
> -allOf:
> -  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> -
>  properties:
>    compatible:
> -    const: spacemit,k1-pcie
> +    enum:
> +      - spacemit,k1-pcie
> +      - spacemit,k3-pcie
> =20

Please update the title and description to cover K3 as well. They still des=
cribe
only K1.

                                            - Troy

--650bf3549e64181e01b13e7f3b0c8c6526d5423fd2d0620ee7d870eb7180
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIMEABYKACsWIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCap63TA0caUB0cm95LXku
b3JnAAoJEJgJ74D5MzQvrqIBAPoJ1V5DULfRR0iJ/PbsZQSGaU27Bg5bTx8RdSGL
sdFIAQCo20UN07hYGkyKe/hWeA2JzbRW4qEfBzGFoFaMdr/IAw==
=WCkQ
-----END PGP SIGNATURE-----

--650bf3549e64181e01b13e7f3b0c8c6526d5423fd2d0620ee7d870eb7180--
