Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F123ED60
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 04:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787198775; cv=none; b=MHHRGVXVfT70MidZstC+THVTG3DowjPRnqpCDAMg4iFIk6DwS3ZPdRVypSGsum+PpAZX6w5tCLOM9o0Ujb3GDeoUeBfbcctKOwIe7U4lTb0oYmp0wbdW9bLYcOswYpjHB04+L0H+VD8zL3yLt1tUn6ayzUY/vxUhy9LlbUAdf3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787198775; c=relaxed/simple;
	bh=BlADO8ID2SPzVugvCAOSKWd7aETthllFAHKVFNnXy/U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TF+2KWvLTPCX5wTkxf2yEE1iRfdj3/7tdTRYI28O+nwG8Fh79XrSe5wprA0PRDCGMmTfAQO4PGuvboy1jPnFJINw99vCayh1DVuQ9TXNaq3WFfsBS1eqtA3ptgDWrChQuyzH+52KmyN7TvxZGLAckLMnat96jzNokswbH19FznA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6NEeJ8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6NEeJ8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38B81F000E9;
	Thu, 20 Aug 2026 04:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787198773;
	bh=BlADO8ID2SPzVugvCAOSKWd7aETthllFAHKVFNnXy/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P6NEeJ8I7zmFF+FSjY6IcV+t7h9Zn6hjK6iqV9l3czNqMV2i3CquvWKMefHjZbC2f
	 R9EIob8p1uIev+chDB0H/uM69qazyOa1x5++79T2ijB7ApocwAxwmlajHibPG1Ts/p
	 aIrvpLcT3+Lh8sm1lYrMI0m5MvhWvp3oD77F/hUXeGJ09CKqZFXzO5KAuGZkXD92IN
	 jLLERbqk2/iHyRAEOwvrGTJCCeUC8AqeWpegsoOEPc+AeGoNsraKvZ+HlAYDHtzBh+
	 7pcZjRnVb7eg28d0optg7MOfHWSmEg7oaY+f1QWodonUdfiipMiQwCld1VRsXW00V4
	 wEvLWgNkmYKFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: Add .post_deinit counterpart to
 endpoint .pre_init callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260820035944.163472-1-marek.vasut+renesas@mailbox.org>
References: <20260820035944.163472-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 04:06:13 +0000
Message-Id: <20260820040613.A38B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> In case the .pre_init() callback fails, it is mandatory to correctly
> undo the hardware configuration which the .pre_init() callback did.
> Intrododuce .post_deinit() callback to do exactly that, undo what
> the .pre_init() callback did. Usually, that means stop the clock,
> assert reset, and possibly program some registers to quiescense the
> hardware. Invoke the .post_deinit() callback in dw_pcie_ep_deinit()
> to retain functional symmetry.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820035944.1634=
72-1-marek.vasut+renesas@mailbox.org?part=3D1

