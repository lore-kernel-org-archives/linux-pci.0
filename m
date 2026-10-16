Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1E649429E;
	Fri, 16 Oct 2026 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174088; cv=none; b=USw2VDGN4qWQ9wzdHAdEf3JrxaXiny8t7uxYsZn69Zb3jzVZjFJy3WfOul1LFWE1uwSrSQu7CAopRdaKh49e8isgOnl6LeTKC48kcMwvGSuzC7IiNiKmVfXuY5g09/WkY5LiSkwC2p1xzQru+nI7PgB0Q6XfVGdVPdA2wKOLqtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174088; c=relaxed/simple;
	bh=RCXemnL0dbX7Nnp69/pPVisx2OtSMyKakyVzyuWogtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=moperBbn5BzspUpsLM6p/Jb90SROWfks8RJCd/QUN25ZLU+5nmWxpxARHEFRBTFfW53PO5qRr3DyNq8EfQqBfeaTbmTlr4b3jtMFRfg1duHVEmhHJEo1Wz6Xo5rao8cvfXR3hbwGNXygE2Nq7bY6Adiw1SIYTTaOCUntMUqXtNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNO1ooF1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNO1ooF1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8ED1C2BCFD;
	Fri, 16 Oct 2026 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792174088;
	bh=RCXemnL0dbX7Nnp69/pPVisx2OtSMyKakyVzyuWogtQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eNO1ooF1W3tgq5DcQ3TVAOMsN+Tfa3F9XGRlqlOVxogyjRB3Jxca9Vthjj75oSFlM
	 f8OP/jYs2Tnv6r5OBrWztZoKaBoWGj/aXx2XWEwbxBnFVQC0HIqi3UAY2D2NTkvuKj
	 m//Bq1WXz/qhln+Et5H5p9s5YmLxRYYebVruHm3J4rEMSGU062G7EBwYfTIgrHlG7N
	 Bc0qXiGFXGII7sM2/AwgwEfGziCsQaOkZ1WITWnOOWwB4YGGU3+xD6TlZpBiZTBRil
	 y8yqYxiZkzfNQQFmlMIw9EJC6JMf+NWaXaURYwcG9V4NIn1p8iIEwraLheHzCWwh0A
	 PjO7t+r9ctSFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D223DCCF2C6;
	Fri, 16 Oct 2026 18:08:07 +0000 (UTC)
From: Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>
Date: Fri, 16 Oct 2026 20:08:05 +0200
Subject: [PATCH v27 4/4] MAINTAINERS: rust: leds: Add rust abstraction
 entry
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-rust_leds-v27-4-2c296d8a8e5b@posteo.de>
References: <20261016-rust_leds-v27-0-2c296d8a8e5b@posteo.de>
In-Reply-To: <20261016-rust_leds-v27-0-2c296d8a8e5b@posteo.de>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=693;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=EpcesJjKwltPtTZ2UkOnZtNgz9x6Hd9kGf/UOr4TELI=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBq0mgFR727Lu8WhqMbhYv/5f8/8lNzjnIt5J+K0
 OLlm1Rjg/iJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCatJoBRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9L+0w/7B/fGeJhW8JnpFBXcTbiNdLobMzP5oEu
 1Z48MyvnqOEyoVDY1UEOEzOMVlgjQbjdqlU9h0Lqnp3kTiuFqRD7VxA9EDIdWtbtFxjL/TPxCga
 +DslbK7JlakdWCdSsOpEqbJ3B4HcUTyxlfQ21HAVOl/3ixDsnOtSHwSptUX995xMQc+Tj+Dl+6f
 Zr570hm1/jERB1vWltaJN/xQ+c47yhY/AR/QjCEg5EEHsI6jkis6nMESY7J3T3MfUvkVz1dbYKP
 qS4/TL1fgqTe/Pt3LxKWwV9rtGn7YyZJB9z9dzm+Zmo6Yx9BTreH4hfpRsHZoT6QmWP7sTnYBcd
 KZRrtuS9j6eRmRkxTTj6ioXte66QFbcBubf1SRvBYYNgfabuIHf6MM+AcQwtCF4OrVE1ZAR075l
 c1/R7/qL7gLuHFA9lHG/3BJVbFwPzbkONfn3tsdH4ib1ST41AygS/G+uxBU6R6TUAVHEh19Ggud
 14nritk+Z8DqqIv5OsyOWwVJlIatHatuV8sljD5HyUi9sG+w37dnh48la+M9Cxb45KsTwXjr/lT
 6RybeEaLIporSn1UXrxI0HBZdJXDFWyWuINhAfxYZqyQyESNnW1d4ax8bjTbyF8ZHB0BOyILs85
 gGWVHDyQSq2skJa0TpFBCXYGJu9yI9L+oNWRNt93Xt/nKyHwBeZI=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
X-Endpoint-Received: by B4 Relay for markus.probst@posteo.de/default with
 auth_id=680
X-Original-From: Markus Probst <markus.probst@posteo.de>
Reply-To: markus.probst@posteo.de

From: Markus Probst <markus.probst@posteo.de>

Add self as maintainer.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f53047aa8d3c..3ae821614cd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14791,6 +14791,15 @@ F:	drivers/leds/
 F:	include/dt-bindings/leds/
 F:	include/linux/leds.h
 
+LED SUBSYSTEM [RUST]
+M:	Markus Probst <markus.probst@posteo.de>
+L:	linux-leds@vger.kernel.org
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+F:	drivers/leds/*.rs
+F:	rust/kernel/led.rs
+F:	rust/kernel/led/
+
 LEGO MINDSTORMS EV3
 R:	David Lechner <david@lechnology.com>
 S:	Maintained

-- 
2.55.0


