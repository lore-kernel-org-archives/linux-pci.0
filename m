Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6FC40DFAD
	for <linux-pci@vger.kernel.org>; Sun,  5 Apr 2026 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775407576; cv=none; b=AHEtMdT2KNTwd+2Xwe5RWAB36JhdfqRyR+YGihS8ClrCV1cnFBspNB2s1qFscE5nbQ5J9VRtnWGmBVNhkjSf3tBCL518fAivnxLrQ6pyRIYwgstDrZcQxJDIbPm6O5j4EhY+W07/TRgCvhNWTxySyP2yA7/Y9EQqwUc0yuxuP9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775407576; c=relaxed/simple;
	bh=6rH4b1A3RO1LJmdiA0UR7Q+GTrvMQsj2ZHkyqJWYbTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONS8kuGx258nkiKt0JZCKtUV1+rZ05DGhBDuClWLg60vOgtXQNDj0manzionHXW4m1NAaBaeUoN62a0JWzfESf4VcvQ0rvsJgkkwSBnBL6DImKy0oI4zcGZMYABDxedvaEgWRjpDhWf257yzT/mUJH40ks+cijHezVHQnpHXj+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=YlnS3f8d; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="YlnS3f8d"
Received: from albireo.ucw.cz (albireo.ucw.cz [91.219.245.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: smtp-albireo)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 24D5E327EDE
	for <linux-pci@vger.kernel.org>; Sun, 05 Apr 2026 18:40:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1775407253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=juqQfy0xnEesq3nPZ5EwZEQKxxF8e1gk/Jj+qFA9RSM=;
	b=YlnS3f8drM+oVHouhOtvA9fK6Jv5QDQUe5TQJNU+LdRXkWx+Pk45piLpAJolvURQ9/turU
	YvhNmVvcvfx6B29xa2SVDsDafTg8UksRcFNUtm8ZnHR/YWSbAWANhE6TsQFY71qoH9KqU8
	hfG5VlpTEMfWAGzZKAHLMPL+8CDwzHA=
Received: by albireo.ucw.cz (Postfix, from userid 1000)
	id 07F7FAC12F3; Sun, 05 Apr 2026 18:40:48 +0200 (CEST)
Date: Sun, 5 Apr 2026 18:40:48 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Brian Norris <briannorris@chromium.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils v2 2/2] dump: Support `lspci -F -` for stdin
Message-ID: <mj+md-20260405.163953.6538.albireo@ucw.cz>
References: <20260108161151.pciutils.v2.1.Ib31bf88c8cfc7ff9aa517fdc4842f7d80b6f9d1b@changeid>
 <20260108161151.pciutils.v2.2.If87a54f8fef6bb9e14edd6a4518b37fa57ef08d6@changeid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108161151.pciutils.v2.2.If87a54f8fef6bb9e14edd6a4518b37fa57ef08d6@changeid>

Hello!

> It can be useful to pipe raw config registers (lspci -x) from one system
> to another, so the latter system can do the parsing (lspci -vv -F ...).
> For example, one might do this if the former has a more limited / older
> version of lspci. Today, one has to write the contents to a file.
[...]

Sorry for the long delay. I had to refactor the dump reader slightly
differently from what you did, because a->error() can exit via longjmp.

Otherwise applied.

				Have a nice day
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
