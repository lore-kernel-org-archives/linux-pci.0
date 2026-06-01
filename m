Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A9029CE1;
	Mon,  1 Jun 2026 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335495; cv=none; b=i07Lmsn3vk+xNW1YJfFmJ3F/BSy/iviMahVOfoaqBBJrovT9+gP7T2iRcw6TrdZlt10Y28+cOIFEvI6wm+k4GShrb6iRCIX45ROoCqHFb6FXM+OfMz8zdwf65KDJfp4IedxwZAJkIf2J4deVkQkh6GiobAJqS7Pwp5pOrjr7wdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335495; c=relaxed/simple;
	bh=hEqYqLf3qTtAVk+r+1pqv1nASrzWTTWGxu96dEN13tw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bGT8E6uFfCbpEMTN1OudryUQ6XqVMj9qjZURYUtfBdhZ2i5iccQmthdE3cgLZXeNxo0Zg8uyk/MP1bLW7mt6lYDkY63BiKwbLKLrzn0kYMES9QqSdqswlWWNx/bDxPxUIic0nPoTIf1Bl6ji9TZ1RKjlDqYQEJyu0pRACYspqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yz8YFjVj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yz8YFjVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE691F00893;
	Mon,  1 Jun 2026 17:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780335494;
	bh=hEqYqLf3qTtAVk+r+1pqv1nASrzWTTWGxu96dEN13tw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yz8YFjVj8g5acgJ94wYNdvk3yF2ynbPugVX3Mf0pta1PW6KMF/JqrzIuz8mtOnEEA
	 ZFQyJZRZFmhmmUDjKzX4QFJyp92UCnrAC06hvCEH7rKnmLb6RA58db2YXdm2EGwJfD
	 YUcDHHSG8Ylys4XcENz/TYVDem+dF7SDwSz+EQVIUsN+9qgUdfYad4pAeeg9Uue2jr
	 Qp9P2AzTIwtrkrTtHaQ2lKqNKIksNrccvccYz2Twn7WfspFMtI1wvnPjTfGQPZ3yS2
	 41G9G3sgdsgk8MB6+twZRG58NV009OTTTmtxBNPf6t9qqLpsPe91mFxZrKQWwA7TZ8
	 c5F4knmjy1X1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: PCI: qcom,pcie-sm8550: Add Eliza
 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, vkoul@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, neil.armstrong@linaro.org, conor+dt@kernel.org, olteanv@gmail.com
In-Reply-To: <20260601-eliza-v2-2-6b44c9c23d5e@oss.qualcomm.com>
References: <20260601-eliza-v2-2-6b44c9c23d5e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 17:38:13 +0000
Message-Id: <20260601173813.BEE691F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message incorrectly states the backwards compatibility t=
arget, making it logically confusing.
--

commit 4700c7cc066f3a08e090817194e16f55e8378762
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

dt-bindings: PCI: qcom,pcie-sm8550: Add Eliza compatible

This commit adds the qcom,eliza-pcie compatible string to the SM8550 PCIe
device tree binding schema.

> PCIe controller present in Eliza SoC is backwards compatible with the
> controller present in Eliza SoC. Hence, add the compatible with SM8550
> fallback.

[Severity: Low]
This isn't a bug, but there is a typo in the commit message. It states
that the Eliza SoC controller is backwards compatible with the Eliza SoC.
Should this say it is backwards compatible with the SM8550 SoC?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601-eliza-v2-0=
-6b44c9c23d5e@oss.qualcomm.com?part=3D2
