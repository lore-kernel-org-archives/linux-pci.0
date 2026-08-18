Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D73F3EC800
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078658; cv=none; b=GJUSO6utTAHX57f9tAlQUBWO3+viA0Hgen53VYZd+D/NYB71Y5G/+GSRtxM17J+o9bucmvGYMAIaJlJWlm2ic0fyXpSVF6eFe6C+U7SR3F4AECC8deFAbqXR/RkebdLA8Rzk7Sa5265n1fh7/QbdcUi07UZHL5SCJMwI//l0nF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078658; c=relaxed/simple;
	bh=/6VLnCrFj77nEpm0xrqvTnbS1Ab1ZKiuI0ElgGAu+90=;
	h=MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:From:
	 To:Cc:Content-Type; b=dVXnMVOvcNmPQvW4ZWlQT70xgAHcyRF9ReMZiitO6539F/xwhebKuLutgiTWtSB19ERVqIgjsI3traWnsW19bwZTQPd2E/1TQouusOcYpLY0slFFhdHGZ5wBnD38gWnPE5e3J4nHuQrtXGyUMmbpjo9wnueq70l6jFdRWnOC4U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f7vre+jo; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7vre+jo"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so343664a91.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 11:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787078656; x=1787683456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject:date
         :message-id:references:in-reply-to:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/6VLnCrFj77nEpm0xrqvTnbS1Ab1ZKiuI0ElgGAu+90=;
        b=f7vre+jorxMTgOeCSGMBMvBn9cXkOPy2ChOSZOIVCQII3oLFCtv1gJ5Byc/ii/NPez
         2pMd27DTkpOlWhEdpyz7YDkKiudYSKab1l0cde39fRE1SBuOJzZfLVyQSw26FFEtbU/S
         1BchutzSmes2svvA3kuYzutpt8R6mvUdSqEyK6ZXYp71kIO4Ri6pO6hkv6Jdx5c2ijKS
         iA9dGu1N64vi0zeDibbtDUIVkERQrLab7wm24t0urcHgQOyqCQOYs3AQbQtSaM9favXP
         2hVK7dQLuwhOF4XGXdjsUCzjnjAkmRYo7wUQM+GxSN/24nP9iDBggIiBVcKWDZRgGvyV
         ElnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787078656; x=1787683456;
        h=content-transfer-encoding:content-type:cc:to:from:subject:date
         :message-id:references:in-reply-to:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/6VLnCrFj77nEpm0xrqvTnbS1Ab1ZKiuI0ElgGAu+90=;
        b=lUtIeqJbqmwACh+ckM1I+UELUvLWZ3LA46Idu+UtDoMGXH4O7r3rl4azN9nVRt05N9
         r5WDHbJh6spC9KxBnqraA26XbRi60fwGFsQuj9HvJ1MqyG/h2k+46VU85kMuVrbP1SJb
         sAMOv55eRNCWBYe94TwqWbdkHT8xd6Vf2HzcEFo9wt9VLXjQTXGYqWlqz8R8DyVoCI6t
         zZ/SmQhhoiwPhSeuhL7MO9S7JCGdkPsH2uf7OvVJykGU4zbCRVNuBeckD5/ryRCrkHwl
         8rjNnbtcQq2eBWR91PfrE38IiYUuqKFsLkdjZ9zMFKiCxum/wXdNiWePos+JjqQBexW1
         CPCQ==
X-Forwarded-Encrypted: i=1; AHgh+RpdGS0wNSgLlxvsScNbIO7uZZYPk9EBzChOzxvhQQQSm3iZa8cgZFRFQCs1MRIgycagkfAwuENuj/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/KlYVWjmg7ujLz9jdmS4NzdJAB5gtX+6TmP8JhFWea5/xjHBE
	Ibr0xp5pxNm37NkNxKgeAtru8Mdn0MF/iaMnMeMHAoAYxVqVjYAve3sxY1tc4dP4EN+b1Gl7vSV
	UdutgqywqI+/AeJudxsnD/zGCQKMgA3vYJA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: from pgju12.prod.google.com ([2002:a63:f64c:0:b0:c9a:eb48:4a8])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:430a:b0:3cc:ea12:dde0 with SMTP id adf61e73a8af0-3ccea12e914mr8687967637.19.1787078656291;
 Tue, 18 Aug 2026 11:44:16 -0700 (PDT)
In-Reply-To: <20260803-b4-fix-aer-memleaks-v3-0-e87159611933@google.com>
References: <20260803-b4-fix-aer-memleaks-v3-0-e87159611933@google.com>
Message-ID: <18ccfa91cd9816e2.3137322e31392e39302e313337.1bc3e0.0000sendgmr@google.com>
Date: Tue, 18 Aug 2026 18:44:16 +0000
Subject: Re: [PATCH v3 0/2] PCI/AER: Fix ghes_estatus_pool memory leaks in
 error handling
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcgYW5kIHJlY29tbWVuZGF0aW9ucy4N
Cg0KV2hpbGUgdGhvc2UgcmVjb21tZW5kYXRpb25zIG1heSBiZSB2YWxpZCBhbmQgcmVsZXZhbnQs
IHRoZXkgYXJlIGNvbXBsZXRlbHkgIA0Kc2VwYXJhdGUgZnJvbSBhbmQgbm90IHJlbGF0ZWQgdG8g
dGhlIGN1cnJlbnQgY2hhbmdl4oCUd2hpY2ggaXMgc3RyaWN0bHkgIA0Kc2NvcGVkIHRvIGZpeGlu
ZyB0aGUgZ2hlc19lc3RhdHVzX3Bvb2wgbWVtb3J5IGxlYWtzIGluIGFlcl9yZWNvdmVyX3F1ZXVl
KCkgIA0KYW5kIGFlcl9yZWNvdmVyX3dvcmtfZnVuYygpLg0KDQpUaGVyZWZvcmUsIHRob3NlIHJl
Y29tbWVuZGF0aW9ucyB3aWxsIG5vdCBiZSBhZGRyZXNzZWQgYXMgcGFydCBvZiB0aGVzZSAgDQpj
b21taXRzIHNvIHRoYXQgd2UgY2FuIGtlZXAgdGhlIHNjb3BlIGZvY3VzZWQgYW5kIG1vdmUgdGhl
c2UgbWVtb3J5IGxlYWsgIA0KZml4ZXMgZm9yd2FyZC4NCg0KVGhhbmtzLA0KUHJpeWFuaw0K
