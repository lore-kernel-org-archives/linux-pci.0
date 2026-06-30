Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9E240BCD5;
	Tue, 30 Jun 2026 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823226; cv=none; b=cWjMzNydWp8oRrT7lVguavzpuHTV4jkAefaBjvSpxCpH/+4ilNxjA2SYSJfhLfMmFzwbKz0j9WTNMGCTW7vsay6iAoarcttBK8RcANsodTZOeiTrGJu7s6jrqzx+FgcdjEPhPpddh92tXYRAREHcH0gNLjP9ftSVntsyYY9gDek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823226; c=relaxed/simple;
	bh=BZDn9zyhiAJotKucvTyzRFglPuTMZiR6GF5jquk1YIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H6MozSEGuMO6hbQb6AtXZ+F40GUHxVcqh5F563YmxTdHrgzfKhlpdb30DC8dJALFsYeboLdtEVVeWxbral9p0LzWVFdGNb2UD/BWsFvQOeLGd+CDNDpP2dZBTF9dwcMn7V+gBaS6Ke9W13W7OCLzndIUQSfQ2vS3sldDbSlD6cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8MgRWRl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8MgRWRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F391F00A3A;
	Tue, 30 Jun 2026 12:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782823225;
	bh=BZDn9zyhiAJotKucvTyzRFglPuTMZiR6GF5jquk1YIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O8MgRWRlM7TURdKX9dsYCFwnrzKbKGN4zl9zy/P3fqFj2FEGG4ruZYuRnJC5XLbc8
	 H9htLP7mqxikcDlwylWoDMnbNTC/Ats8f5zNpBFnHZJOv3kUdXWfUm7deMO0gvZC1W
	 2s6RT1ygnjzcxrhBu3zl9Qtmyc4/NzenDJ6ocf37NKdxOUmq9w3tTF7tTeY2N0mEzs
	 uh/T8jc1ERU1YpwNDpCGU6BsJL1szfJ4N+pQ+kI2k/+1GyLuN1uAuS9OptiL5UlKv8
	 QP3hDYgpREuLfBNKo1U5wQCES2F13bXcUrIQMN8/mDCn6Uu3AhFCds/sceNT1ZrN0P
	 y1UZU0sliTc5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/11] RFC: rust: driver: support map-like syntax for
 ID table
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260629-id_info-v2-11-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-11-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:23 +0000
Message-Id: <20260630124024.A7F391F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The device ID table and its associated info is really just a map. Add a
> syntax to `module_device_table` macro that reflects that.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-id_info-v2=
-0-56fccbe9c5ef@garyguo.net?part=3D11

