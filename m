Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940564;
	b=Qc/vcR3SU0Wj/5R7bcv3XQsxoUBJkkTchDQhZRd/m0xQQN3lxZIvfmNqqenwFv7knj/n
	 2xyL5t0l1JrHlGJ+zzI9u3nn9Cl6+hIv0Tua0haG4F9mV/CJuQfXrSsePKSczREWzxRbe
	 6J0L8xamdnEdlaPOoh1Mck02bU4CN7SBrrffHBtmQ6160YlGqRGfyA6/VdMX8NI+/MW0y
	 q/BK4DC8TEOyQMDSK5vfe3OO+9oqjtr1wm5WOWYkwPgzjpfYKfL9cp3XmhPYo44iJ0zgB
	 SnyLIDPFBoPZRi0KZ6uGDZ++d19elz87Z0xpezK2XqGxe17zXMo4lBcBAjthKCFtBog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Rd0/jqMJRNHoYlSsIu6TbBr2fty8j4sVOq9BB4+EiWo=;
	b=M/+kbUeLFrVlRzShyXJD5ZK85j1fWrfCawmfNaQjZe/i0Ws+7s5H6QgVHJCIYn708Tdr
	 TTsT+fw2hF6oFHXr2z4+uhu26AzE0MlGPbpkZHq+Hqk7cy3YlIqBTjLmOGuPO3gbnPczp
	 t96WM86FR97TBkB00rRe9Ps5Ji9GzVbUjPrnxiZ5QNMKEgx9//lZLq40EYBAzsg2BY/CP
	 VJ+zfmOkjyzYo+RrMgL290ZKbivCI9gQmS2fqCEiDYUKrGuNrr9NVxMYw9IHFzSjGwsF+
	 1hSs/VAX20dM01Q2SJLr5llDQ3rYCmN4lz+tzZYcbt9bnOUZmF40DjaxKBwG2H570BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NY7Dxxv6;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A98E606A32C
	for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 18:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A98E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NY7Dxxv6
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a3c08d6928so239336c88.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 10:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794940563; x=1795545363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rd0/jqMJRNHoYlSsIu6TbBr2fty8j4sVOq9BB4+EiWo=;
        b=NY7Dxxv6aQyYfqSCSaWjfqzlhJ/a0bl+46/lxBlI2EQayiWmonn8eCPcSEZESRGl0F
         O5M4p500Fwjpz7EkNJxewnz1RFnmp2RNQ6T6l3lGogC/6kpQz/SrhY1etzeEU7KoM8VW
         TncEYyGUqKYYcl/u7ZaJkylK4s+Nt4kHmmvGgb6Nra/zO5O2y70qeP3K4xK2/Kt9cKo9
         Bi0FGRThL5Anv71ugGpHxJ0kxJFN5dGESl0yy0qgweB88IJmtB7O992TmZlIxiCvp3GS
         uZ1VgIfPe3oU1M9MuZxrdUZAsf5vEmCymebCYp6MKnqLQVDQNIkJ7vlM3HZF34F7+9b1
         BSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794940563; x=1795545363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rd0/jqMJRNHoYlSsIu6TbBr2fty8j4sVOq9BB4+EiWo=;
        b=Ig88Uf6ErX3zJ+XNr0sPSNtcb7yH5wKaSewjjHWfEDFY0zIaeu1mszkjK3KWvyO/RQ
         tLPHCM0TopZdjaqFswC7Pl9ojemyALBccgM8p+rfm3k20fabMliVY8nteYdTeNv8OQNr
         TFiSSPGzik+PSTROYSAO0pn0nX19v1XjED4nW6ArdcL/aQqq/vGBwjzOCTt6kv2e+uK9
         /zwzMwLIF1bb1g+o5sQudUdHIvL5luoWYPqqUo3//ZrNkSFb7oqxWTj9i6PLzIel3vko
         wEepmN1L/nJx7Ma/PYM1cSXMgHaqDIHi0GYANozJ7l+mqSqRAbge3twts3BhcBGWzQD7
         pYSg==
X-Forwarded-Encrypted: i=1; AL+hErEIN/Vpj+EJKvw9GIor3ZypSy6GY3yTFGvnCExPPv886Dq9uUQB0Q2yeTdLVXh4m8ONtk+v0KU5oL0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uG76owlVStg8y+Crh2m9L8bDTdSrQIhAuj+GfQjgVesXTgKZ7
	S2Pua7KUeyN415+0wb+8DkiD31vVKynsd/1QTfvEf7jq+Rq2szrquR0=
X-Gm-Gg: AYBFou0CuwI0V+fFOo6Fj3BaYy5UxlU8I7UnCDhE/YHVE5rLE3io5AKYhJur/RUoisB
	D0Y+tYoSB0/PGeZkZEPmzLFnhCOhNgIKLooE5irYzvvmqLgE4mltVgo7u+9yhy7H9YILrqry239
	rFR6M18Kfm6KeQEqs17dwPYBnnEeGHg4F948hkVmHOWdq6XegeQdy8q4TDvDy69yrVemdKTcH+c
	QceNEa1PnFKfSQQyKpchwcERAHaSzNKhk50SdUEJ6pydnSxWhhhcg7mOwkHtBP/4WOZGRYd/HPg
	9aZQvu+TBFrNKg5Cv0MqVR/SmEOq1aSB9DyrYKWODZ/rO6eMf1s4hFroPGfdBL76F8WnXbKTrWh
	UtYhSompxfGy8bQ0gVYYvKlefIh2eFuH0CSD2BLTdfFYqo+1gvFaiCRultcgtcvB5RuB8xKWJjy
	6ZDDOoX2Wr6LY3jSTtKbiccxjjXzSl6roRTtSVrFtOvrvdjwF+nCplPM5QIf8tDUN2rxMQ1QZ8R
	8HrVVST/aZ/SXqbkioXzHG+IJLpf9ymrVsY1J0YQd6uB5O5KCqlL1OTLOj+h2L5MtmgO8NgXg7z
	odXtPXbkDTwXmV30BjfoszRjbzvVkhY4Vp7WFsUCXvbGMtbQBlQlRKRYnZ59JdI=
X-Received: by 2002:a05:701b:2409:b0:1b3:b833:6565 with SMTP id a92af1059eb24-1b543cd7213mr469644c88.20.1794940563273;
        Tue, 17 Nov 2026 10:36:03 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.59.94.173])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-380d5135221sm10562926eec.24.2026.11.17.10.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:36:02 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: helgaas@kernel.org
Cc: airlied@gmail.com,
	alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	christian.koenig@amd.com,
	dave.hansen@linux.intel.com,
	dev@deq.rocks,
	dri-devel@lists.freedesktop.org,
	hansg@kernel.org,
	harry.wentland@amd.com,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	kenneth.feng@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	mingo@redhat.com,
	platform-driver-x86@vger.kernel.org,
	simona@ffwll.ch,
	siqueira@igalia.com,
	sunpeng.li@amd.com,
	szgit@icloud.com,
	tglx@kernel.org,
	x86@kernel.org,
	yossef.osman@proton.me
Subject: Re: [PATCH v2 02/12] PCI: Disable pcie port on specific amd devices
Date: Tue, 17 Nov 2026 13:35:46 -0500
Message-ID: <20261117183546.1214-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116202343.GA205416@bhelgaas>
References: <20261116202343.GA205416@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I don't know what's going on here, but it doesn't sound like typical
> PCIe behavior.  If a device is powered off, accesses to it end with
> some kind of PCIe error that is not normally fatal.
> 
> It's basically the same thing that happens when the OS enumerates
> devices by reading the Vendor and Device IDs.  This has to work even
> if there's no device present, which is essentially the same as a
> device being powered off.
> 
> So I'm not in favor of trying to avoid some accesses to devices based
> on DMI checks.  Even if that works, it doesn't cover other paths like
> sysfs.

I agree, this is not standard behaviour, this only happens when we use
GMUX to turn off the rails (which is the thing that causes power savings).

Accessing PCIe space after GMUX has cut power to the rails will cause a
CPU CATERR.

Also i dont really have ideas, im not really familiar with PCI core.
Can you give ideas, you have please?
