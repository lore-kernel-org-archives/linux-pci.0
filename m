Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7354F3915
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773564; cv=none; b=HF0WjHT6EOMKvb97aV+0sA4/nb1ltvES4wSEsxyjA7/RNf9e/D9fNLP8wVZLcmFwQbvx91Xuq2dJKSMpNeQinRaxUHv90snX8LA7ApGCtRnzVgFP9zJ0a8qhQ4VuzsbKHrBZAEIaFqO3kIgZ9NGIULPiEF+hHkfw2ROmUga99To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773564; c=relaxed/simple;
	bh=XBQeafZ4HH7kzXuhlxlrOFwSavls9meqpVU02VwtBlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ngQVLWpJLJhIwMZsVvIYnyvWKgHYN4n/GrHYFJ9FIxzFCvkTNo9ArZIr8VEx09lcwpsTQrCCYjd/VKmaBIGFKOM29ZooLEaGplTiFVenGNGN0DbRoiDNc61q18o1Jbw6vebUVMNMJxT/jG2tw4DhcrbVhlV4BrCBbgkjKfQZWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=mBUOju1S; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="mBUOju1S"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 7EE55240111
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 15:05:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1790773536;
	bh=1rJMZOoXjsvOB65KPMvqkp67+vOa9wcF8nHsjIlYKVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=mBUOju1SSz5WoIC9VOJBETEP+gJeU1vcodjt3Dh/NI6fd7zZA5EPFCDDjIRa9ixPC
	 xcsiOFyqHo9ZMfPFyoedb1pXHN89hMdDrjRZLD6EsHQPpa5U9oaaRXrE1x/pYx5y1J
	 +WeVQoZJrpz/e7akEPjfYIz0sc1ZERH6lgfghfEcngYSq2JZYGbT0tSv8148EI+AcH
	 f5GQMAeU6brK+i/zT5G3IS9glhM/WW2xm2mqTo61TSoK8lPS8hQrYgSCaCg6dXJo6G
	 wVW7Tha7sNIG2VRCgz5BfoP9mYFyI2DogZc9Pds6gysGxP+yPH7F4JX7fbx24xZ2ad
	 u8c6yny5RtXOQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hvwJX4gzxz9rxL;
	Wed, 30 Sep 2026 15:05:32 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Wed, 30 Sep 2026 13:05:35 +0000
Subject: [PATCH v26 4/4] MAINTAINERS: rust: leds: Add rust abstraction
 entry
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-rust_leds-v26-4-83837331020e@posteo.de>
References: <20260930-rust_leds-v26-0-83837331020e@posteo.de>
In-Reply-To: <20260930-rust_leds-v26-0-83837331020e@posteo.de>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Ira Weiny <iweiny@kernel.org>, Boqun Feng <boqun@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=693;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=XBQeafZ4HH7kzXuhlxlrOFwSavls9meqpVU02VwtBlQ=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqvQkRmCUkSpzb9LqSuvqpTJwh5LIT4HwxnSNrE
 M++BJUeKLOJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCar0JERsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9IQOw//WpFpvF5bzo0xjIK/m87C8+fLEYzrFrr
 NUItZc1ezn6rCljwFIN5qB0UsUFIfNzStbygQyxRb16mCzHeiWbgjPk9GKMqwK5j+2iZnavGM2g
 TojeofoA210lCM1ydJ3cr8ouyVeJCKrma7ebOg8kNsnnsSOzJStXtaorVfUHfXUTP2qH7u4uRBQ
 r1VK8uq/tO3H8wTYcDvUD1AOGYwZ/4L8n7mXOmqgoV90XcVTC5/kFb9i1zgPBSp/sE7+QfFE9zz
 7/KNhxFrYSQiHjFSg3t+M0X7BXudcW19xtOibjBCKtnpwTzAi52MXAdXEISM3V+r2qYaLpJOHqT
 dnIuuB0D5POfWcRpIpnE7Sa+IgwGZW7nRLMy6S7uUxtKTGB55p5KxkRk53zbqvH44Jwsm174Wz8
 cwwTD9rrj/yeApZyO2hvl5+Lr6jtDs87fc7Hst/oj04XEHv5Hv89OP0Sqc5hW9uHCDeOVmyvmh4
 vz/ikj0QXBxK2mEi01U4VtOSKOnDjMo1UC1/szj1r2Nd5PopTkPlHW2R2ArsZ+DWuIUEZOfQVCp
 7FyMErGtz/RAy/YqoUSoj1cm4ZtVwNmBVoF/olVgJ7TR19yTxZiuBVe5+PvZzpaeGLyWHJlp3U/
 wjOsqwPC+pdhudkcGE5DtSy0fzRDIYAa3WQ4Y2D0JCWhb6LYFOj0=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Add self as maintainer.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 72294ddfa5b7..aaebc4e541f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14790,6 +14790,15 @@ F:	drivers/leds/
 F:	include/dt-bindings/leds/
 F:	include/linux/leds.h
 
+LED SUBSYSTEM [RUST]
+M:	Markus Probst <markus.probst@posteo.de>
+L:	linux-leds@vger.kernel.org
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+F:	rust/kernel/led.rs
+F:	rust/kernel/led/
+F:	drivers/leds/*.rs
+
 LEGO MINDSTORMS EV3
 R:	David Lechner <david@lechnology.com>
 S:	Maintained

-- 
2.55.0

