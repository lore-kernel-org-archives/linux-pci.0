Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042BA3C1089;
	Fri, 19 Jun 2026 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888711; cv=none; b=tjeQzWPtf+e5NhN8DiCztxyFhKA5/JIY5WH2DHw8x1cmRlWM7FCaAE9ZDNzR++8OmNayPTxVP9cW9JII5Jqad0mQ38akGD9FZVGnuc5lU2G75c1lxFxiJAwD584C0LSGxdwnBPN/8tw7aAfPe9NOs9QEARA2Wd082bQXw/VrSCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888711; c=relaxed/simple;
	bh=4hFSJbLjJdVvEruNcpXNrm5TQZw+01r2kmFGRAFhdAs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g129CN/ulvF54vOfh4ZpJOApL828NLQotWu4DhsSOMAr/j9Mx7KEgZ4teG73TUMGLUyYRH8sPlZS0stM0jv8EXpau4UfFsCOwHTLVr/6GFe/RsyRsgI47iDZRMcCZxFcNZwJOM3hU+HlbI+4g8px2SSzDv96h2mg9uQiK9svIOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqhaNj/U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqhaNj/U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767021F000E9;
	Fri, 19 Jun 2026 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781888709;
	bh=4hFSJbLjJdVvEruNcpXNrm5TQZw+01r2kmFGRAFhdAs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZqhaNj/UP2341Ok16bAGk6xFLSMMJju51wPHZW/HyF2/yr1/qOBoLEcPh0oFDsr4M
	 geYSWYkLaC+2hYznb9gf7l4RNcugt22IxEEtkRwYBoWIsLDksDUjgcySUHd0VCcohd
	 bnnShQ4lsvKvnlyxPxSAfXhBn/rKdYnIX9aQ4aNoOoR6IYamuu3fic+0wXirnjOUlD
	 X7jY5UwZWTyDvyIINJvXdGw1HSKkjpenXlFAyBlrmiE5/bHR3meJXMBjMfV/fAzs58
	 1UyTE9fPENL6r/F4yscIj2lgkQqkq8PnyxqXXG1swrJMjTQksBUBCnCAmIisM4XW/x
	 2hYGEG04CCU4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/10] rust: driver: remove `IdTable::id`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org, ojeda@kernel.org, robh@kernel.org
In-Reply-To: <20260618-id_info-v1-1-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
 <20260618-id_info-v1-1-96af1e559ef9@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:05:09 +0000
Message-Id: <20260619170509.767021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> This is unused.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-id_info-v1=
-0-96af1e559ef9@garyguo.net?part=3D1

