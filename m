Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909AB207E00;
	Sat, 26 Sep 2026 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790437685; cv=none; b=WXo6S6eRQs7rmXd7WyQV72XN0A2IZSUP2xTWdgeq8RnCZzaAart+5p1XjTecBgHqKR87tEShMFKttYHZvRqc17B0kKe4cXCjIaLXTMJni7E+PAfhBojbbgcPxcCKd7Yhn1d9VRJOgJV1s6NDurkFRWeqr1rE7jDy7JbOort3RLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790437685; c=relaxed/simple;
	bh=87FNPlW5aGENkgmF6YyCDNz6gXqxOkfGRoLH/f4V0WM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fEe1Xft6bfxkHko2nCtKG251sEQ5EpZv8gC2+rMXAjbekQwspR2eMSybEkCFZOSN6Zqs3ZxZNZo7au9BFA2DnKfU/a+88uiz5VC2WogALOX9pPETZEpGKa29+OrtWvlnXun2TNcU2Yyc+aB440agjQ7m7ydmlb7uIOwZTefr0hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hqVEgvlU; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hqVEgvlU"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E0C0C415B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1790437684; bh=Ei0FDW78/NOpRyrWYZyT13yRH2m7TcgQlD7UoQ8vgu4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hqVEgvlUZ0c654JIcag2BN4BSgYoyxWRRfbmXz1UTon5b+8nC+AanNs0+cp+vXXCQ
	 VHUzNd9yn43LO0iudAwpYb90AE6Gs9Cm/D9sjzRvL39rnAyMmyJq7tzIRP8r2JWcW1
	 htPlEpJU/HwoIZfUhkiMSdaYCcx4CgbYbcqxwWeGDsDTVmkR9uVwWWNxI/elWqb96X
	 JADTfNi18Lgq52XcBjPz+GcS+8hgqrXx9m0O+AuwdNLw04wZg6P9K3EqdvHb0b8vAC
	 0CUuh9/2gwQE14LU2MGNCebqcVcPhWHP1ZrdZloNPYjDJC9s5OWR5NYdwXcyekoGZL
	 4v1flPT2YiO/w==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E0C0C415B2;
	Sat, 26 Sep 2026 15:48:03 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org, Shuah Khan
 <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: ABI: sysfs-driver-xdata: use literal blocks for
 console commands
In-Reply-To: <20260923025018.848769-1-rdunlap@infradead.org>
References: <20260923025018.848769-1-rdunlap@infradead.org>
Date: Sat, 26 Sep 2026 09:48:03 -0600
Message-ID: <87jyo82evg.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Use a literal block for console I/O so that the lines aren't merged
> together in the produced output.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
>
>  Documentation/ABI/testing/sysfs-driver-xdata |   20 +++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)

Applied, thanks.

jon
