Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147772;
	b=1/K40cjnUzogOcMRe9G2UnZc6TaAVTUmSbDcf2//c+zSiTlXRT9XZ5w35c6aR1DnKLJ4
	 uc0e6GlnWYa94QRXRkI5LTkRVUZHJ/6gWUCAvXkLd65fNqWlqpxey5flftEttXoG9eg8+
	 P8RO/RMR+17TvSQw0i1M9U9Ck6/RRTrzh1Vj8YkRX1Gj1DX/DTG2izr2NDOLzEMeRyfHl
	 M7g0JPVTtvWYRmZnGgSqB7UANxx7wckrxw78eBqoZY8SWcT7qIpG9Y8y2ZOZR7ocSn9yA
	 XFwBT45BAY0TxNJgWjjEcYuR9Yt/O6Zm3svx4g104MFo/yabJlWVywOKOyr7aHkVaNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147772;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=lDzVcp1bTgJqeWMJHHLt9xWG+oSgGYewvfT7h6V9gqk=;
	b=rJ/iHAjfYEujGLz+TwzvkPhuNXDPnGtFe2Tsfwv/kQqj534DiPR1hktQLR7Hys2RK/oK
	 dOYfTuZ830KyLql9FKRk7Nv0IedSwF66vGwGRF4EEfq4H+H6h7i1qB+fnzoqgy6w4w/y6
	 JyNgjnUOc0Xq44eyGhaorE9e0z7NwyCp/Ql0C/3mm89KLJu9/Ik+e/NzoiydDU+9Sa/zo
	 9Qd8hNWsz8fA1+vVR18RmWBiacAm0xqV0MYuLLEucw/53dJvCeYzrRrmfSRlAsLcWGQZ+
	 Aeus7zGc8dk51aC8QUVdnDYRsX8knWdXY7CPq62M2Pj7A3xPwNk70jyRa0nrm1WEBFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=b8RVwu1v;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3IwuG92D;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE64606A320
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 14:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CE64606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=b8RVwu1v;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3IwuG92D
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 726D4EC0236
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 09:22:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 08 Nov 2026 09:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1794147770; x=1794234170; bh=lD
	zVcp1bTgJqeWMJHHLt9xWG+oSgGYewvfT7h6V9gqk=; b=b8RVwu1vXK0QBfk0pR
	+n1rq6wsI7x7yPEayVsgTKpoV0HuETQ7M+Wjb5HlRGdAqfeKno1BytXwW12nq3y5
	DaFE6Yf9IssjZYHbf+TnAssW5/f3QcXlftmqzkLqs6o5YXPfUc7jpFr35VBH1q9z
	dlHz5Zl4ODbwEkCXOt/xdbjlZlTkyycR36yU64hat+UXTVmxw0Asza9XespUwNdX
	ffko4J1UvgdAYdVwPoabcFTeJaI8sTU+HttZoXMMHGsXjFm5Zbz0+dsbKcWk7pni
	hJpfdQl+zpOm71kTybvNfO7izUm5y9zxdGFGJUpkGaC8DklhTppfMNaZVulrzHDS
	I5aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794147770; x=1794234170; bh=lDzVcp1bTgJqeWMJHHLt9xWG+oSg
	GYewvfT7h6V9gqk=; b=3IwuG92DuIplhpgvDwSmntV2pwMpoCzdNDeDWrXD9IfL
	GVQVmEsEN+UX7BExavvJe72ii5j/q+jbs/4EaqkgLy7LAuieQYL7VBo0HeNvcypP
	3lCopLJmClZyepr/ORvIbXqBE4SWURK0xGx0zFqlkm7XO8nvJxsROiaXmnrZMRde
	iSGsJ7Ro1CsXG77kHfwcdOGviWQA1w3Ag2mOp2ei5Lurj9uYJfZ9KfKqQzjxaGAH
	Cp2MzQPsnvGPAEwp5oyBBrmKOsxtDQjMbmlwAU7K+YM+ilgWkJs1yladNKjKk/Aa
	vfsCJ5zyMi+uCIVIRbuOLLwpEbY2sOQ/XdR8MAs6QA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794147770; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:SbLiqhQpYVoUn9Novsx9gvtGPUnhPUREekIahNFIrqXVecv
	Ab9ulnqX4kaOlA1mGO9T0+Kl16jJL1w5a+Pb9pMVFpS1QYqrAhcYSRqJzKW0Jvrc
	aj3WLyWz462J8uQyaJO8Mdyzyr2BrCjjXU71Ag4XgKcHz53o/6KUHNTKaJZeSwFI
	TMlsx25MshO9FE8hhYTXyyCLLJ2Exl3B/sJYAMH+lGVp5ZtpBQwiwyhhNaEHJYaI
	8sHyZvcsOduNsEOXR0Ci5T+gAkEBCw6mTo1xwCbC4/L/hsxnUCowZK4gvO7usV4r
	QMsYCVwDPrqUPC6oLju5eU3L7wvf2At4Z7HeawQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:1NsXmGMa0eRM9nJfuJllF4HmbWds1tNITnd/go8q+lg=:1FSI7VpvI9HBAJVh0slm9bQWgX2OZnVpTVVJnzGdiI4=;
X-ME-Sender: <xms:uYXwasT14ATms39quBxYU1WCqxTlQ4vt1-WdRPk7n2atbdeQB4Y64w>
    <xme:uYXwaoKmuQwOyP5BetltZ01_jWwrLohjwyYmgUEk8AwFOd16mpjgG_9V8GINffeFl
    235LFJylvBIL9gR5CsQ3TcqThfW0dbqeSJc4uk48VGXTz2EX2coTls75w>
X-ME-Received: <xmr:uYXwal1q6O3Lkj5jJ2q5zWGM4Dy5wbM93Lem8vbUWWd-Y5PBJf-RNvVAZ7gKEyvrgqEtDOE83v1ax1IVOOiHtsQZhorUhwyaxn8>
X-ME-Proxy-Cause: dmFkZTGVCEBAWNMuvpK4V017RQEy3JhGATTzG9560omovpYbMERWekm4tSfbH36O9c5CLA
    hlj4+Qh9d7zUKlcLlScb2uKVP+8nPNz+q3+eRgDfvfGuQqeAc6PuIQSCphJKYt818Y5/5O
    dCf68+QuC+S5wGxW/N+0qDcQi2fKYs5+rnAK3oxCobmCYfEh4Iq4sXcmBhgI0qvpmd2iZq
    3kk66y5Aw+XbqgARuRrcMwrc+XawzMSNmc15eIqnIa1iHtB4GlObjVV8DXocDGIDILClvn
    rMZMZO3miwdfJJCMMCsRkDc2g6cIv9vJ8VRSoBWSuEwCGiczcna3dI+n55rI4cBEv2IkOs
    eoEQDCYlQ6KIOkyo9brIX8C8nc+bnoLxNAFSj228VlTNmj4c4fiBElSs9DDXPrQtRy0CXd
    dOT8NAH8Nkhs1MvJO9yG57hUrJ0OECLZpW/Tr6I80RTKAEpgghpWO5V4thLX18+AeWSpKN
    shmbPp46ZHH49uPJvpetiSJdcSyXZEU+lSWWpM62YUaiqHm1EPY53X2TkhDBMa0l4lOJGi
    M6zWkbFznuN2utKcjFxgG6IjDpKfnJclDa1Mf6fS6qvV28GuY7PWbuSL66iI3anbJdCknO
    eDOjAf1hBiDhwDb1HrruHovzxRgppmSsdhLS4DpUBGeSLk4x2qFch3eURScA
X-ME-Proxy: <xmx:uYXwajJunI_g-4ZmnWA8ZJAjIQqh0jSefe8LCczdCwmyhnpKIhRF9Q>
    <xmx:uYXwatn4fayorFh4hXlZDfN40zOIOIxxzYo-scXIM3EPcTOEjsnxHQ>
    <xmx:uYXwapOeUP9pkQF_SJSyslkYEg-xO4u8BZD7H4tFrL6NUlvFn1CiUQ>
    <xmx:uYXwakykCUyCURyftSP-VI5hahvKhEoIzyuClhzTJcoVQbfvyGgs3w>
    <xmx:uoXwamCCWno5wVjIbz6sgCBxyNaQMQt9LrPaUiwPVBny-NAeba1m95cu>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 09:22:48 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH v2 0/7] Apple M3, M3 Pro/Max/Ultra PCIe device trees
Date: Sun, 08 Nov 2026 15:22:34 +0100
Message-Id: <20261108-apple-m3-pcie-v2-0-0e5ffec71da4@jannau.net>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NQQ6CMBBFr0Jm7Zi2IhBX3MOwGOogQ7Q0LRAN4
 e4Cxo3Ll7z//gyRg3CESzJD4Emi9G4Fc0jAtuTujHJbGYwymdYqRfL+wfg8obfCSJybukizmqi
 BdeMDN/Lae9fqy3GsO7bDFtmMVuLQh/d+OOnN+7XPf+1Jo0JWinJDmUqbouzIORqPjgeolmX5A
 AWZfv69AAAA
X-Change-ID: 20261104-apple-m3-pcie-ae72b846baaf
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Joshua Peisach <jpeisach@ubuntu.com>, 
 Michael Reeves <michael.reeves077@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>, 
 Yureka Lilian <yureka@cyberchaos.dev>, Alyssa Milburn <amilburn@zall.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4167; i=j@jannau.net;
 h=from:subject:message-id; bh=1FSI7VpvI9HBAJVh0slm9bQWgX2OZnVpTVVJnzGdiI4=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqwPrVu2fjqtLSAdVC3y2mb+qtUcnt1vzPe6rzzBtv35u
 ndSLwq3dUxkYRDjYrAUU2RJ0n7ZwbC6RjGm9kEYzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjrGPEwMUpAFOdIs/I0DndUYFXoTfY7tTW6S3fKx/3Wj7g/fFXx4fvTZ7ksiWn1jP8D3ux6c8
 esRkTlKviFfcciMhitv03MbGBVepGbvb5umVfGAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Hej,

this series contains the device tree changes for PCIe support on all 
M3, M3 Pro, M3 Max and M3 Ultra devices.
The PCIe controller on these SoCs is compatible to the M2 Pro/Max one.
So add the new per SoC compatibles to the dt-bindings and add PCIe
device nodes for all M3, M3 Pro, M3 Max and M3 Ultra devices.
The series contains a fix for the M3 (t8122) power-state devices tree
nodes. A power-state required for the PCIe controller and the NVMe was
not correctly represented. MacOS keeps this power-state always on and so
does the device tree for M2 Pro/Max. Do the same on M3.

Based on apple-soc/dt-7.5 [1] to avoid trivial conflicts with the NVMe
series and to import the M3 DART dt-bindings from [2].

The series passes make dtbs_check and make dt_binding_check and does
not introduce additional dt-style-check --mode strict warnings with
dt-style-check from next-20261103

ciao,

Janne

Link: https://github.com/AsahiLinux/linux/tree/apple-soc/dt-7.5 [1]
Link: https://patch.msgid.link/20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com [2]
Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v2:
- capitalized PCI and reordered words in dt-binding's subject line
- adjusted WiFi/Bluetooth PCI compatibles to BCM4388 for M3
  Pro/Max/Ultra devices
- Link to v1: https://patch.msgid.link/20261105-apple-m3-pcie-v1-0-e00a72a604f8@jannau.net

To: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>
To: Neal Gompa <neal@gompa.dev>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Joshua Peisach <jpeisach@ubuntu.com>
To: Michael Reeves <michael.reeves077@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Mark Kettenis <kettenis@openbsd.org>
Cc: asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org

---
Alyssa Milburn (1):
      arm64: dts: apple: t8122: Add PCIe device nodes

Janne Grunau (4):
      arm64: dts: apple: t8122: Keep ps_apcie_phy_sw always-on
      dt-bindings: PCI: apple,pcie: Add M3 generation compatibles
      arm64: dts: apple: t6030: Add PCIe nodes
      arm64: dts: apple: t6032-j575d: Add PCIe device nodes

Yureka Lilian (2):
      arm64: dts: apple: t6031: Add PCIe nodes
      arm64: dts: apple: t603x-j514-j516: Add PCIe device nodes

 .../devicetree/bindings/pci/apple,pcie.yaml        |   6 +
 arch/arm64/boot/dts/apple/t6030-j514s.dts          |   8 +
 arch/arm64/boot/dts/apple/t6030-j516s.dts          |   8 +
 arch/arm64/boot/dts/apple/t6030.dtsi               | 165 +++++++++++++++++++
 arch/arm64/boot/dts/apple/t6031-die0.dtsi          | 157 ++++++++++++++++++
 arch/arm64/boot/dts/apple/t6031-gpio-pins.dtsi     |   9 ++
 arch/arm64/boot/dts/apple/t6031-j514c.dts          |   8 +
 arch/arm64/boot/dts/apple/t6031-j516c.dts          |   8 +
 arch/arm64/boot/dts/apple/t6031.dtsi               |   1 +
 arch/arm64/boot/dts/apple/t6032-j575d.dts          |  72 +++++++++
 arch/arm64/boot/dts/apple/t6034-j514m.dts          |   8 +
 arch/arm64/boot/dts/apple/t6034-j516m.dts          |   8 +
 arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi     |  41 +++++
 arch/arm64/boot/dts/apple/t8122-j433.dts           |  28 ++++
 arch/arm64/boot/dts/apple/t8122-j434.dts           |  38 +++++
 arch/arm64/boot/dts/apple/t8122-j504.dts           |  26 +++
 arch/arm64/boot/dts/apple/t8122-j613.dts           |   8 +
 arch/arm64/boot/dts/apple/t8122-j615.dts           |   8 +
 arch/arm64/boot/dts/apple/t8122-jxxx.dtsi          |  29 +++-
 arch/arm64/boot/dts/apple/t8122-pmgr.dtsi          |   2 +-
 arch/arm64/boot/dts/apple/t8122.dtsi               | 175 +++++++++++++++++++++
 21 files changed, 811 insertions(+), 2 deletions(-)
---
base-commit: 6c799b8c0df41869fa0d059f7e54f8f84b3989ee
change-id: 20261104-apple-m3-pcie-ae72b846baaf

Best regards,
--  
Janne Grunau <j@jannau.net>

