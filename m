Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57972E3AF1
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518521; cv=none; b=Pe/AGYKxgtNZTNIjNrJ8vQow8WWxxlxwGzDB5xdmCIOUZJWcxKRNq2Ck3YEWFhXiY99YVZVmDs2GSo0y1sHUL3RJ4TQE6AZr/HUT5TPWOz2P5SZiqJXVZazYbzTP2Yxunf6Xm3GTVzhvTIq2jipDy7shAg/h7JN9sShJI1sxn64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518521; c=relaxed/simple;
	bh=Q5Qk0KHQjVZbp0lFmVKnGWZtxtkKr3ZAe8XmELX1/6o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=PTI4Q9TixTIIBZ/K9mY8tIjhMx1hl8/XjjRy6qmF4OBsCIlRSKQU9SDKD1ODn1DfKFpNG+KQtTIyrDea3dlzVumPuSK8ik+uIPzsuAfO2oqoVERiKctL9Vm5RIqVMacbIPIrDQKUeHaXSQtmoRaeeBYWpEbFpdgLvAHdk4Wm7ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtX/OGdA; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtX/OGdA"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c7050a48fso5716301fa.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 06:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783518518; x=1784123318; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bzsuqGeu2ZztC5uiYt7ZwxUJKrCKRdPms1njvftvolk=;
        b=DtX/OGdAhe7yA91L46I19bvLHRht6xiVp76N1JqMr1SNWnF0qz2E+9vE3j0Q66hqBg
         ZsOQzVJxz13O+Rxpd6rmvy4MOVZ+kYbnZBWDBSygnTYP11PlfYZjLphRnEXQe0bgDYS5
         ItciuIvXjC2IB7C/6Fbdou6GB+MxyX11hIlyJqxAgTbUemybl/2i18zdYp0PZXqj/kgE
         Q5KL9A95KfbhqWY9elL2ay5Sg/d9w04gwxZmAPxHro/rUPorZk/HN0B28tdHBjlwl5q2
         hu16D8B6+3s1fPrEooGQgJoLUN/tQVQF5RPA+5XBLACeOjPdS+t4d7va2WlnXndAQkxw
         A3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783518518; x=1784123318;
        h=content-type:mime-version:user-agent:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bzsuqGeu2ZztC5uiYt7ZwxUJKrCKRdPms1njvftvolk=;
        b=XOABmWeYzKR1NfLe2NTPi45oJxoCezLQ3Mdqf5K0lEPpsS3EvMR/tQWy9+Bv6YhZ3u
         uKZxXZkvK9CXda5ZFMA7ULBQ6weWFakbiD/hIWtbpC3oO58DFjkSRu71KgRZHM2OBBtm
         7uG5ZaOWBWHjSL2bCExdIHQ7/EmoRfXCqikJDDV/ZcXwOhbidOzUy0AVL9D9l/xNOJSf
         6+fw0UU/KofveSPeGZea0dt2SAI79m3pDQuPL+10SRXf17UhsqQCZ1QXAcIZwn0Ean3G
         CbsAEcUsned7PmOdqN4J7q5ugJFKL8/j04niphcZNlTHJ0uJJ0Wj+3lEvjOeP8i9awd9
         24OQ==
X-Forwarded-Encrypted: i=1; AHgh+RrMXvASp/G9wumCJy9cGAG+eZWIr3lEvQzNG7n8f3Zs8XXs6Ot7ONMrQj+aJnvNbgSHm7aP5TjE7ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEd4hsQtkUDLgMPRcbCAbbJTbPdgLXQgPJSM/1frnaITfQINX3
	YT0dJL0Orxnl/jBfN9m9ZyvDPOu4QUQ9lgD0w4rB9T96bOfYMhF+a93p
X-Gm-Gg: AfdE7ckUMpZFzmUE3d8Pf5m1/ih5f3t5n3qYn78DXMZpYU0D0H+5ccI6RJsNpophg6D
	KxpUZfhJXGghz0qGxqFGacr483fMyiCe6Yfe27wkx4lnQdUzHQNedOTzNV1RngqXa7ktPTWr1sN
	QZgdnQmMYsm4qBlv4oh6EnqsjvDGQTqpgLgAx3hhKa6XUCUglPjrRLySu2D6OfO5jyrFq/BwFKU
	YTyQzM4puZkOurrwQoBqr6ekraF7CDjCpw25je/nu4PIaG1sgx9o5e2XymQDrE/HakMK/ejcbDA
	YIq5RljkFVpzNzuZWpfQNqIspvGPvkc4D1YYdOgLIP+lM0Hc7DiCUgsXNBfgVdiCXuENv3pqGGS
	KmDuxH9R+5P+A1as7P7XCjo+wD1dPJwF0nyrHNIPag5rKSWp1f5P122PNNYfy6Tf/TZ2z1hwxM+
	o+8fQHtO/Y7Wm/1J6BNixfvc/Jx1ck2h1rzLD1jRJTI+wQCT7W
X-Received: by 2002:a05:6512:66da:b0:5b0:eda:de34 with SMTP id 2adb3069b0e04-5b0114ad7b9mr525977e87.43.1783518517539;
        Wed, 08 Jul 2026 06:48:37 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:eccc:7ea2:9458:892d])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed136f8dcsm4528257e87.11.2026.07.08.06.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 06:48:37 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Dan Williams <djbw@kernel.org>
Cc: linux-coco@lists.linux.dev,  linux-pci@vger.kernel.org,
  driver-core@lists.linux.dev,  ankita@nvidia.com,  Alistair Francis
 <alistair.francis@wdc.com>,  Lukas Wunner <lukas@wunner.de>,  Jakub
 Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 01/15] netlink: specs: Introduce multi-message blobs for
 SPDM
In-Reply-To: <20260705220819.2472765-2-djbw@kernel.org>
Date: Wed, 08 Jul 2026 12:13:57 +0100
Message-ID: <m2y0flbuoa.fsf@gmail.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
	<20260705220819.2472765-2-djbw@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <djbw@kernel.org> writes:

> The SPDM, Security Protocol and Data Model, underpins PCI device security
> and other use cases. It defines objects that allow for verification of
> device identity and configuration. These objects can be large in size 16MB.
> Netlink is otherwise suitable to define the operations, with optional
> parameters, and notifications for working with these objects. For example,
> operations like "regenerate evidence with nonce", "mark evidence
> validated", and "broadcast evidence / security state change events".
>
> A netlink 'blob' is introduced as a way to teach YNL that one instance of a
> attribute may span multiple messages. It enables netlink to convey all the
> data needed for verification and manipulation of SPDM transported evidence.
>
> The schema change to allows YNL to infer that an attribute may span

change to allows -> change allows

> multiple messages and interrogate its length to preallocate an
> appropriately sized receive buffer.
>
> The design direction to extend the netlink schema for a "multi-message
> object receive" case was the result of this discussion [1].
>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Donald Hunter <donald.hunter@gmail.com>
> Link: http://lore.kernel.org/20260318170014.6650d2bf@kernel.org [1]
> Signed-off-by: Dan Williams <djbw@kernel.org>
> ---
>  Documentation/netlink/genetlink-legacy.yaml | 6 ++++++
>  Documentation/netlink/genetlink.yaml        | 7 +++++++
>  Documentation/netlink/netlink-raw.yaml      | 7 +++++++

I suggest you drop the changes to genetlink-legacy and netlink-raw
because I don't think we want to support the blob functionality for
legacy families.

Can you also update Documentation/userspace-api/netlink/specs.rst to
describe the multi-attr / bloblen API behaviour.
