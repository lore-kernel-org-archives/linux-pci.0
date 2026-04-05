Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7213F19E98D
	for <linux-pci@vger.kernel.org>; Sun,  5 Apr 2026 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775407388; cv=none; b=Be4qGdh2G5eHpYxViod7YkpVPyiz2exKRVLLKAHK02JiPYf0lcNZBzqENmGcx65kuPkVwUmhvb7I2maRCxZWjj42oIzMrmsz13j6MpkLHRZRbIRmizwOi8/csLfQtNZsh3XHP/Ws/auj702W5HwFytJJTomFRW16SVb15iSaZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775407388; c=relaxed/simple;
	bh=X2nvHyhAMY9QcKBrFlH02djHj5E2ijXqj78qq0fo69w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPXaYoVRrryt+duvJerz/eyI4ak5Lgl7Th7a9/2G5//qqq4AqdrUJsCgtDBih9Y4GQSz8XBKAYVY56+pXYpNXIYN0od3FdhCxmijuolyDfgEN29V0vuBMef3GRMuYBImYIepIMn5OFH6FH0j/LrO8+66HSd7PC7oyksEPUsymtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=Z/ilFzfy; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Z/ilFzfy"
Received: from albireo.ucw.cz (albireo.ucw.cz [91.219.245.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: smtp-albireo)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id D5488327ECF
	for <linux-pci@vger.kernel.org>; Sun, 05 Apr 2026 18:43:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1775407382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BB+bt/PfEfMEUae0XEiL0Z9mONVW+Y42EhmVhg/LZfs=;
	b=Z/ilFzfyEnvfIQ8ZI7Ix7GO5nHDTgDv98j2rFDLSB2tNCVL1UqK0YcrykjIGNioltgZL8o
	nNmd91YHATisdYkmimh8tDQUkaaXeetVu4tLp/hb5vmnSjltmlu9/Jb2L9L+pyUyurIlIS
	iz3fBGorfigeVC76XX431ZGwu91Np/k=
Received: by albireo.ucw.cz (Postfix, from userid 1000)
	id C82FCAC12F3; Sun, 05 Apr 2026 18:43:02 +0200 (CEST)
Date: Sun, 5 Apr 2026 18:43:02 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Rudi Heitbaum <rudi@heitbaum.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2 pciutils] libpci: ecam: Fix discards const from
 pointer target
Message-ID: <mj+md-20260405.164249.7151.albireo@ucw.cz>
References: <aZpR5wfDQ7fg-4cl@4c9b59f0293a>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZpR5wfDQ7fg-4cl@4c9b59f0293a>

Hi!

> endptr is used as the return from strchr(addrs, ',') which is a const
> char. endptr is subsequently used as a pointer to the token which is
> char. Fix by not reusing endptr, but declare addrsptr as a const char *
> pointer for use in the first case addressing the warning.
[...]

Thanks, both patches applied.

				Have a nice day
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
