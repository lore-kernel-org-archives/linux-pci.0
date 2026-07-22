Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1379D33F59D;
	Wed, 22 Jul 2026 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784683249; cv=none; b=ftZTFzFBvn/4W7fWmowbOCqFYcyESwCtSXKFnvVC/UHWITeCUe4ENNhOBcJBbYAWdcGKf28Z9V1I9V9vLtKuezbmobi5XeBdSf7JNbF87hAUV2ySgh9Borv7R1EFdnz606FCgJ2jg4ZlXconWsyGp5fAQGxbLuzaApF7hhIHrg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784683249; c=relaxed/simple;
	bh=smq4+xak+szqWoadQ8bNslqOH6zhtfHCIoaYy6iL1AA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/6OVHeZXVhcDPXUcHwzWvOyDB5asQbg1kdTJNP5eTir4kffd6hIDjBamoN7UKmT4HRErBRjKX04OfjXDV6JtsMwDbNrQGwZ0wAPOs+YaT6NdnaRPCgfK7BD/83B/29cE5L4BG/wE2AspnW1xwSSIjfaRES1i0y2MJQpS+RC85w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCqEOQ2W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCqEOQ2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7792F1F000E9;
	Wed, 22 Jul 2026 01:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784683247;
	bh=ObPnHJ0MKv4ncqtwpHCsfCD/+7Y5pA2C8huBEdLkio4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aCqEOQ2WxN3Z/dWhfMtRh3rjkycICB2Lui5fNv3MlJmrI3yNebCPLM32OlBxrzjfm
	 zKpByMIyrpIjbHe+DyFb32xN531PcX2VxhodcmdTG4YuO3hibcW64+z5ypUZhyvey/
	 O0a+kGVcHe7/3mtMzY0p+lR+lT2lZiSexIcCKn8i0nR3+MfIwvGBrBvHIsKFtLv0AL
	 rTm9Ev6Kd4WKmueM49j722ot3qfhkGLIfbxcqx4AA1s/uT3m8MZiPnsxY3srpgpZyx
	 JaK92FfeMMz0I77WAUblvWmQQQgE5IlYsNCm5w5TILp5RFWW9rfyakqofzsFdCdT//
	 0cwK7ojN+QxwQ==
Date: Tue, 21 Jul 2026 18:20:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dan Williams <djbw@kernel.org>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 driver-core@lists.linux.dev, ankita@nvidia.com, Alistair Francis
 <alistair.francis@wdc.com>, Lukas Wunner <lukas@wunner.de>, Donald Hunter
 <donald.hunter@gmail.com>
Subject: Re: [PATCH 01/15] netlink: specs: Introduce multi-message blobs for
 SPDM
Message-ID: <20260721182046.16219426@kernel.org>
In-Reply-To: <20260705220819.2472765-2-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
	<20260705220819.2472765-2-djbw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Jul 2026 15:08:05 -0700 Dan Williams wrote:
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
> multiple messages and interrogate its length to preallocate an
> appropriately sized receive buffer.
> 
> The design direction to extend the netlink schema for a "multi-message
> object receive" case was the result of this discussion [1].

.. continuing the tradition of creative abuse of Netlink.

I don't like this, sorry. You need to come up with something outside
of netlink or more netlink-y.
