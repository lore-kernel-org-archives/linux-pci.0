Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E12EEE7E
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022987; cv=none; b=XGsU8F2bfGEX/jI+240UlXFfMGzgZGLJCRMG1lrwCbl+DSwW/g4bKBTZYEcdf3SbkhvlusA+InldR5o/l4++LjT5Ti492DysksxU51sLLaE3zvGwaldy+GDN3zp9vR/YrMEqCix36M51l0xT5ed+YtPwtst7O+azAQcnySAnNBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022987; c=relaxed/simple;
	bh=dO6VxnWdSF/0UJe+1zjPxSzYZsu4rRGg353uds0O5gE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BAa6kzdx1gzi78c1+lRFcs1C27RwEGKrYWR9WziA0GwM4vOFjZnSIEoUcYY7a4ZRxR5MnvslzLL6BhwGVyr8aPXKd2tGYpCssumGYJmNqnjBuqGRvx2ZrSTvwVZTRASdJpaRKzIFsuGMQJbmDYzPdusjcV9udpT5IBYZSVnj7AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPFu9vhC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPFu9vhC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345351F000E9;
	Thu,  6 Aug 2026 13:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786022985;
	bh=dO6VxnWdSF/0UJe+1zjPxSzYZsu4rRGg353uds0O5gE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MPFu9vhCDTnxdtuNbdPvnC7d8cBUGd4TTF/MmcSPjMHZppSMXddtEh0fbh2FdmB5t
	 EKlf7MSSpVMvZlecRsfk/rQBmpcf2Lt/X5YajFUFHLFoxW/CG6FstAJ8zbauE/VQeS
	 8aW5415KGfzhvRp2qIguW/eIyCwzZl3i9uIvEnusUoy2JmsNj6M6G1jPffOomdqD+I
	 zY/zmQY7XxfTC06PkAkgKl9rdbsS0aSE1RAhcGSKzSmrJE9m7GbEPPxU7Bqyfb7jZm
	 3MGyis0U/jnjqIn052gbcm8xduD+eaiu8fHLkuf1SPGoFCz9VDfctJk4yFlU6udynW
	 e83NFyDqT3E9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 10/14] i3c: master: Add helper to query bus wakeup
 requirements
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-pci@vger.kernel.org, linux-i3c@lists.infradead.org, Frank.Li@kernel.org
In-Reply-To: <20260806131857.119830-11-adrian.hunter@intel.com>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-11-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:29:44 +0000
Message-Id: <20260806132945.345351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add i3c_master_has_wakeup_enabled_devs(), which iterates over the devices
> on an I3C bus and reports whether any of them are enabled for system
> wakeup and have IBI enabled.
>=20
> Controller drivers can use this helper to determine whether wakeup
> support must remain available while the system is suspended.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806131857.1198=
30-1-adrian.hunter@intel.com?part=3D10

