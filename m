Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831E44CAFC;
	Wed,  8 Jul 2026 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520419; cv=none; b=HiiScKVfunrq1rlbMtWv5M3w/zrr9snIsPVOieB7mFA5EZaplbx00AgsgbUP1Y2VSL+LWZJoEugUD3rvLlcyu6Gti5pUCuGSgkk6Jcu/V5TNI/wRJvdcs4YA3HkDOxkn57Pfi5ZX6zFaeBRnw7VW5gfPTON1OuicxQpi++xu5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520419; c=relaxed/simple;
	bh=/dWJyZdeb50M1UWbA6nA/Mq52oSFBMfJGmOoam2Mm0s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IfOL4DQNZrNLM9A6BNClbAWmjdGH2++C3eptUpL0o8rcGc5yMrHldailjoYnoMnQKin1jyrLrjvIXFgSIFhMvFoZcjIMZXw09F/ZKSBhCFHBTgKxBkJjxxWwMxN7fc8RxWFrC9SDJCsAEaPv+sf9r/DCRocOqo9fnZ+y7//eYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgfZs63F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgfZs63F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C359B1F00ACA;
	Wed,  8 Jul 2026 14:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783520417;
	bh=/dWJyZdeb50M1UWbA6nA/Mq52oSFBMfJGmOoam2Mm0s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kgfZs63FUc/rltU5zlEfHlFiekJlV4W2tr9nu1q9GJWfuJu8HjLbW/nmugC9APOKB
	 qym2XlidwIG6WsAaFmzptTbE5TUNXuJ8fz2SfHTxeSQJlIetBfHS2sUW+7GI4xLo+C
	 /YfZZqp1O+pj5q7hjwH7YoDdiZa4sMy8cSGUZWteLGXCnBfppSN2quFApeHXxA3IPL
	 fj8KhG+kmezQjO7Ym8HHydY5Zjpqpnkys4N6xdFJfwxzAtFJ2+TDhN0GydRF4/lR4P
	 COBeFGHlqNcvbe+L1lrvEosnBYiy+thOP+d+TzxlqCvZFyYX/L9JQVYgjXooj58kk8
	 o3AXKwDeeDmxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/10] dt-bindings: firmware: add arm,ras-cper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ahmed Tiba" <ahmed.tiba@arm.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-9-8b3a85216cef@arm.com>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
 <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-9-8b3a85216cef@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:20:16 +0000
Message-Id: <20260708142016.C359B1F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Describe the DeviceTree node that exposes the Arm firmware-first CPER
> provider and hook the file into MAINTAINERS so the binding has an
> owner.
>=20
> The initial user is the upstream zena-css platform, validated so far
> on FVP.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-topics-ahm=
tib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com?part=3D9

