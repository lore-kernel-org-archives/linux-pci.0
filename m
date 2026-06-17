Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F6F49252B
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711434; cv=none; b=d3Nsa8Uo0ogMl/66aN7H2Vrk9TloLz8qcoSeO1U+ZRfTDakDOjQSVrUkwmMH37kLQ9uONDD4Dz0+kW0F4tRU4Kgn+EHrRy5pRHEspJ4d586YNpAnCICb2h2c4/QCA19NLd2RAxoeMng6saPzG52FpGaWUZvcOZ9B6LnmL5twsMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711434; c=relaxed/simple;
	bh=t/BILcB67xKXUmHaGI6hCcLUgqok0CX9vUSEzaSgvqg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSSwN4rE/Fsu5HSd9BrL1+AvNXkaug+1lNEtbMzWTU12N71k1WLS6f0Eu7/poLSlsJdiUahOycthTeFkfVP60Przo22kD06i7Vx5fPZa0gScVLxYVbEoEpR6Is4MnS7EmHoAkXotuqrGOUtBHuIn6FjFA3rAA+kLSFoRr5piDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=gsl2xsx6; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="gsl2xsx6"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5176ca6bab1so12373871cf.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 08:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1781711415; x=1782316215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrCHhmxOINO44tH4bViEDX7JiKeUT/u46hgEy9drkI0=;
        b=gsl2xsx616O2MsHBdOVBqf/qiiQbEiPY5Y4YAUUZMzDbS9cAuJUDtp4JuoTWiyEee1
         J3LfI+wKGv/voVsHyFz/+A7FM9MpCtE2/hQK95lL/w7vtZ0KZjhnWPdUr2HC9dxinvcL
         OiFKfBKdXAuyBk1mYZJXj682TbzTx0Tu6BXfQS0J7sVDsfBob13zcZWZu2fguSzkdQ+J
         KcoXRcAQ5Mqys8F5ALeUmkrdtSo7Z3uZEEmKVFeJIawH9Cv9YSJVaXvqFQgQi8ZQ7iOD
         KdVUlLYHlaJYz8ow1jvI/jOz4KRiwvf3JB2l2mQFq45ynh8nTXzo8iZ4ZJkDP1Vy1dwQ
         wtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781711415; x=1782316215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZrCHhmxOINO44tH4bViEDX7JiKeUT/u46hgEy9drkI0=;
        b=TZibF8bnyHYVn+NSPaI9bneZA1yzaPZ/Dn9KxO+xHkJlR63jGM1ADTDEM7LbKZDkz2
         rFFWGbJM/fzHk5fqrDI8nLHtMvX1ftoNYxV0730D8FvrsN+HzpW/PbM8sWuJYCGtm3fP
         zwxudwu1ozekNBrrw8deYsqrhGp5hAo8WM/syJ1tX+zBJVKokkpbQFOUW06mptLby2Lo
         VsnXXWUt7M9HsWpC5l87AQl5aIw/vlDabt7VSJOdwvIkF2e+i1sgXbHkGlWdEfYJtrmN
         8uqF4cG9LGr9DJPwTRZnQkVQmWXl9txv1rp49MeQBzFewG5ILRKauZ/Pj56AqIMSsfma
         8d/w==
X-Gm-Message-State: AOJu0YzOnbZ+dVlC//6AIs6ffT1fqT+Qhmuq5oPMiJheMIRF6yCYjACy
	n5OV3HPp2nd7zEd+fkJUeCwF9GoZegQkbKggeBrcy6GG5Lt1dHF1ZZxlyqtblswpmNdyOOhz5x6
	eJgA=
X-Gm-Gg: Acq92OEUHbLE15BiI9En0iyUOrckdDWYcd5bIZo+00fypAHG+X33B/8uuh1H1fYyl79
	TipnpJ8xVXg1BcWr0ERiI2tjKhAxSHwuhEeUzzvhBH0pxgJrS6OB8WRxEN8aYb/zMIme3DysX95
	h0r31emiYzz/7UsYgm5QJ+ADqJQIfpBKhibg7+8PWhJayDEbuH7qvzBQrtuQaowH2wWXjFA2uK9
	8KfuJGRkYtlTxECoD64vSoJnE8wZasuE8B9B+eevkt8XrLoWQIOdr+kIQiTikH2M5/diOVvFcSw
	dkDoUbAb72hNA4xYfqFm0drwzK2rrljuxUnKiYfWVqT0iz87BwqtP6044syCfTgD4XQ4PUcy3kj
	/aQ4s8PnaMCcX1yhLgUn0nRqmuN35ba3eWjMJwnmdzyvv/o94C0+ZDK9P7N2sH23ysFACHX8Zyy
	xnoLEfwDaUJF+1QAgzTr3IgroUJGtcz75Jm8Mkj6kyMICgGP9S+dLopWLk
X-Received: by 2002:a05:622a:130b:b0:517:9407:5c38 with SMTP id d75a77b69052e-519c4d9e360mr630241cf.24.1781711415080;
        Wed, 17 Jun 2026 08:50:15 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:2008:aeb7:73d7:d8ff])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7dacdfsm178862081cf.20.2026.06.17.08.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:50:14 -0700 (PDT)
Date: Wed, 17 Jun 2026 11:50:12 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: linux-pci@vger.kernel.org, bugzilla-daemon@kernel.org
Subject: Re: [Bug 221073] xHCI host controller dies on resume from s2idle on
 AMD Strix Halo [1022:1587]
Message-ID: <af0ae5d1-0eb6-49cd-8317-6e8c25d06c04@rowland.harvard.edu>
References: <bug-221073-208809@https.bugzilla.kernel.org/>
 <bug-221073-208809-WU5d6V9tJ8@https.bugzilla.kernel.org/>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-221073-208809-WU5d6V9tJ8@https.bugzilla.kernel.org/>

I'd like to invite people on the linux-pci mailing list to pay attention 
to this bug report:

	https://bugzilla.kernel.org/show_bug.cgi?id=221073

Comments #14, #37, and #38 seem particularly relevant.

In short, the problem seems to be that after resuming from s2idle, a PCI 
xHCI host controller sometimes does not get MSI-X interrupts any more.  
Setting a quirk flag that causes the driver to use PCI INTx interrupts 
instead works around the problem, but it's still a bug.

I have one of the affected systems but haven't tried to do any real 
testing.
