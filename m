Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442501;
	b=zCySQGpWINOq+Fa150n0uzCmM1RD54iU+v0LbJNJK3JvlavG57q3HdGfSSPDp+sIz5nO
	 YCLXG7t5tLnya8t6AcL41TPBz0ciNaRUMxd349sJhu5sSY3T3V2V51bDWPjm9ManqA+6y
	 KkWNYBrytkldXgFUgB15Gxtnt2bO4TTuiI298KM8yBViR/iJFlisHZtHGNmKYG76n+8sQ
	 7LN74fmEVaM3OexkIBGdtc7Gb5KRDj+C5lCvhuRIFYzMc+jJZ/rFTSX3iOYEhsWo/RdIZ
	 9u1wz31ye7HaP7ryJPq/Y0HuRuuQiNJLI1kmXWxWRnPcvobH1loc121LSYyLdEx6OkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442501;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4ttUwgHMapJGyc7rNA5a/9mRW4Y+oL+SZ5Y/WQQi5QI=;
	b=iO8QNksSRF+aGwUftWDWcx1WjeDkHJlg932loqhYd3dhb1O7srJYqi2KyFO1HyRYOam/
	 ENfXck2SzmSLZLiiJi00OULi95rJivZiZRb4GRTxHLA/j+6IaFl37xqc47GOp4a9cAEmm
	 4K3ChyYPOozzY61PHsoV7MHtHozlZrH19ju4EO07c7EpJWLYoMow23FvrIjJ4aTn8+gEN
	 2Gv7O41CgbEZiz4qWBkn42XY24vynV5i98E3/6xwkoKDBjvVspYhHF4sbi+JkQgqzDZrC
	 rJXLBdcjgAP31/8MCftuRsPLF8UpUs5u9XFSceFPuDupOFp7n8+LuJOOT/0n1xXh8/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZxjJA3MS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9432B606A32A
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 00:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZxjJA3MS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B721F00A06;
	Thu, 12 Nov 2026 00:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794442501;
	bh=4ttUwgHMapJGyc7rNA5a/9mRW4Y+oL+SZ5Y/WQQi5QI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZxjJA3MSrRCJkgOg7PAtE87TPnV48eYuAe7Vkh0ZSbD+nlriLt77sIPMMEy3sQZYw
	 6CZKVqaDT50t83m+2Y4rnqvRr8lThF2GZy3GTeZEWOdlkqJeV17ItrPvkggLZ4VqKO
	 /7hAb7HxkxZFJ2HmooOLO1rg7tmTxaH2QPhlZKQk/7YXKZvT6h8JG0Q1zFiqc56fkh
	 RNDp9lZMQxXSxk+XDSMn5ih+pDkwcEcTlFHICFuaI+H+kqD3zJRzQx2BB/QO9Gwrpe
	 n/owYcBiRQ9CbAPVrkyCsamIuTkZblxY5Mq1kLS5W/YMWE1aU0JgoWY2Lq9a+A8XYx
	 ZPAVJbdU17T5g==
Message-ID: <sashiko-outbox-209889@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] ACPI: mipi-disco-img: Include <asm/cpu_device_id.h>
 unconditionally
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavel Popov" <pavel.e.popov@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261111234821.4814-2-pavel.e.popov@intel.com>
References: <20261111234821.4814-1-pavel.e.popov@intel.com>
 <20261111234821.4814-2-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:15:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> <asm/cpu_device_id.h> now has a generic version, so the #ifdef
> CONFIG_X86 around the include is no longer needed.
>=20
> <asm/intel-family.h> is included by <asm/cpu_device_id.h>. The CPU
> match table still needs CONFIG_X86 for the INTEL_* model defines.
>=20
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111234821.4814=
-1-pavel.e.popov@intel.com?part=3D1

