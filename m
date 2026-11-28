Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795827602;
	b=0eHTd58TKvinyxlndvauFwpZWMhaAI4GxItfqQKO02kbqj/vOEwa/LC5sQS7XroWLfAh
	 bUfZlUnj4FRtCK9xtENr63W1m6QclETRyA0jSa4Hw7ybfyKd5mufoRirvW/0p+vUhcnot
	 OpG7mVtWJJjP7R8cmQAmEd8I21JDIC6qzV1nlsGDMoQhnxV1/VEHjRVD2O0fi4EzOzAVZ
	 IR2PCuEX4ev74FuaEEX0B2uhOeTySnWx9i5TDxQI0YZtNlQ0XvlW2zHLG2WvJUOLX4+xI
	 9y0kFPP1QNhy/OmIgeri7eApawAdl7hbszatNuMMpLay4kIcXFxB1O5XLCq+01bMeBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795827602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:User-Agent;
	bh=r4Hzxb3NGCSSYFn+Gm/a38nZ3OBSGBwiKOcgfEfvzmI=;
	b=ykHJHcI4jk/2aTBpBgoLyovV1tPnelG3zRXyFY6wQ7Psk7bo8HE9ke6/jcik/n3cbmtk
	 IAF/q/MQ6+c6kq+M54UycRkCeARLc9pytc6G4LUdKvsLk32JjiZkqg8FEheppAA0WnSgP
	 nuD3AOz7azUhOlC+ojdTTXOu3nAHSI52GOTIZAT8X9AnWGb/dQQZ+gWf6O+vdlX/CA6PL
	 7gOkZLAvIFGTLK9TTXRgDixqZ6stiqjeJdztvMgPdEKhGtKLtSvnbgcQIjN8Lo1+jmJUw
	 NHZ3Jm9DW4b6MrQPD4h8we00L0887PbrUFN6T4utcajkYC9pfWQAc4fxW/1zGFBRNmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=NP1xbr9a;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FFD606A31F
	for <linux-pci@vger.kernel.org>; Sat, 28 Nov 2026 01:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37FFD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=NP1xbr9a
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b315dd057bso53972207b3.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 17:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1795827601; x=1796432401; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r4Hzxb3NGCSSYFn+Gm/a38nZ3OBSGBwiKOcgfEfvzmI=;
        b=NP1xbr9aYchSjWccz1YTXtcUDfu6Kfw7+2E32BWhvFBJmtxKt3JqsAbSmWtkpkCxvJ
         /n9tD+yjbaBtMGWG+AOAC1Lc4BDVGli5hZj1dVoJsB/Nz7WwUmsK0vXUaXNixMLnjPnF
         /zr1HcO28b2gmxi28F0WybfMWXJ+PgYtDJlek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795827601; x=1796432401;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r4Hzxb3NGCSSYFn+Gm/a38nZ3OBSGBwiKOcgfEfvzmI=;
        b=T1JJim7Ke0Q/k7f2ixBAyxVhsYH6D1nymzsS3Y18MMK1PnYnv3JKy3fDWFXvkTyr7R
         oukgjtSiph5U2uxmp4Jg9Uv/65qsUGQJEwiwQENGhXnV/KZJsiCDnqLrlbjSSXWBK1xs
         NGf1jaJ0xRKURYbpJ/0DUCaxK+XB54sc8vPyRrNcgfyz3IPe0rGvyIWa/p1Gp0WCvtv8
         8c0shLS4DkhUNhyLacaxE7oY1FRToUVFK7U4WpoO3bI0PiBPZk5X1NlMyd3/drbijEPb
         Axg8ByuakELI4PahOVaIZ3duM89AKXdt8pUftW8giQmmMLpGoaRPV8c+a7JvVf1YLQIf
         YARw==
X-Forwarded-Encrypted: i=1; AL+hErHbJTkb2CnaSvsJtoJLCoYlZmmuaA3Cn+kLgCIijzrfiPbj1rvdPxXNEsxhZR7FUUelxevGS2EJL2w=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RudMEm2cy66vsUZYxB5Rp0C9KQ3ZYiLdC2BvWJh43VY+wLdyc
	xZQHAGu0hvoLMLu7MjvpjQk0xWZ2eR35DcYHCO2o4yHDMEKj1OpBuSDqKyN/vBI9w2E=
X-Gm-Gg: AZFdTZfXfpmjcI0/Xaqh+bYrVlonc2OZn+NRHJIwmJqrHDQ0l7sTLmuB4dNkvgAM7ek
	x4Lj27CypeHTi0bRxN2MBouXfyog4SIDDTNfgYEq0Ku1Xa+kUCqbG+ohNrZ1/nfkby/F9EdH3OI
	h6ewfgzZPtg/QZ+J0w4kpy8KtQyt0MetehyBbtethI3bFYGLdDENfQq+YnbGaZsBp2V1DT45O3x
	QpGx4PEkampNKcjxUXmOqmsVFdSmbB0vXxgA2D5gvghh/c7uWzQDAI/jWqBD79S/BNn84LvzALX
	2LegTfigKeTnQOf3N6Hz466dW/5YCkBdSeRtukXXZbE+bj+jP3bQe9roGHx4MyfXlRPDxDBSnep
	d2TmY5/rmhE7A2jSywfQP4AQUc3+eVxej2WjPec92z/j9V1H0FN2OHC3ZBKwXgrjB0/MGWjQKP7
	dAjPxZIM97kpsXot9dMEXT2ujl4bBGD9/61Tjo4CTlaZtyLbo1maEVUEpTFUdeUgqlj8cMnhoWQ
	EEMmjqUJzDgMsbYnR1iU4+ftKogKq83jFc/KR6iP9zNDXbnbG6lVlrQON3hZjI/Br4UhWmgKYvB
	DdOLXCApWOVN44koi8t5JVieN2OUaqgnyEBSn4P+WtJDk5EfbrhINOisJs2/nqks7zx2hPTRqC/
	lR4RX3K2gtSqbFq0Wbb06q0X+V5Ar5BUBlXGpWrIt2/4pRcxzEMIM+x/oRPlxcwpzhaM6k6wWEX
	AjwaPWUMF12rDBxE8DiswH92YPmuKYwwm3fJlWgYhLLnDztPZ7gUDxZx9lL36JYT3LHAX2cpk/i
	poxGaUnuQ83/pBt+HJMkAA=
X-Received: by 2002:a05:690c:b86:b0:8b3:4911:2dc1 with SMTP id 00721157ae682-8b5204ae0e7mr116512127b3.39.1795827601141;
        Fri, 27 Nov 2026 17:00:01 -0800 (PST)
Received: from [172.20.0.2] (c-73-207-185-9.hsd1.ga.comcast.net. [73.207.185.9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202bf474sm101002207b3.21.2026.11.27.16.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 17:00:00 -0800 (PST)
Date: Fri, 27 Nov 2026 16:59:58 -0800
From: Chris Down <chris@chrisdown.name>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, David Matlack <dmatlack@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 6/6] kho: don't reference subtree blobs as FDTs
In-Reply-To: <20261127122536.3708770-7-pratyush@kernel.org>
References: <20261127122536.3708770-1-pratyush@kernel.org>
	<20261127122536.3708770-7-pratyush@kernel.org>
Message-ID: <awonjgkHO4wSeAGO@chrisdown.name>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Pratyush Yadav writes:
>The only functional change is the rename of the debugfs subdirectory
>from "sub_fdts" to "sub_blobs". Everything else is a pure rename.

It looks like two places still refer to the old directory name:

    Documentation/admin-guide/mm/kho.rst:110:``/sys/kernel/debug/kho/out/sub_fdts/``
    kernel/liveupdate/kho_core.c:1099:``/sys/kernel/debug/kho/out/sub_fdts/@name`` when kernel is configured with
