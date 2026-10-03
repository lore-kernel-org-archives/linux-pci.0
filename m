Received: from mail-dl2-f27.google.com (mail-dl2-f27.google.com [74.125.229.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E07939CCF0
	for <linux-pci@vger.kernel.org>; Sat,  3 Oct 2026 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791067042; cv=none; b=W1I2QEvIPxwgX+h1VuzkBHrZZO8xlT7iaLyy/MKY+oBmNiPfwhBFnbLLG4Rsd1HznKkxyMqICfpJoGvuqtKXQET1dUHluwqjLecKzdE4mzn/mRfz9/s3JLsOTeXoc0olxbaa/mnkkfibCuUoW9dAyNC0AfzlAqNXpLTensc3X80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791067042; c=relaxed/simple;
	bh=kz9Gv08Ifi67EI1jeifT4K+itNfN1SXPlehL2hJ15qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOH/6R3F9NuEU2skPMYmm4vLxSFvmvpRllEZttUwOGKT91HWn6mSvu1rqavyFJNb4D4CzwzFl4od3aUBE7QlmcHDL/dDOAkwwshjkmnjALo2aJLShMJFoUTf5baUgedFqQ4UfW9/bjjwtZ91tn2fET1XDKuq6mpfANOFZWIeYY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzYGMJqY; arc=none smtp.client-ip=74.125.229.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzYGMJqY"
Received: by mail-dl2-f27.google.com with SMTP id a92af1059eb24-151af368f59so23051c88.1
        for <linux-pci@vger.kernel.org>; Sat, 03 Oct 2026 15:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791067040; x=1791671840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kz9Gv08Ifi67EI1jeifT4K+itNfN1SXPlehL2hJ15qc=;
        b=mzYGMJqYcmhDURPdRu67LBEZ+o1PfXPH4pe1/jxtzAuCR6d9HhiPdJw9H138nYYOqt
         ccp4KsbuOPug02leV3wC9moW0ffXBzfIKDRhTBQ2C+tVmBrrUp2UDrtbL05in+458glc
         HSTbvsCUKByBuqhOvunudS0z/3TtLV0lNxNNlWztd5lgsc7/dzGt8kw3R8OZSGYVH5dA
         Zy5LQNhpd7jhDclG2z4tzdPHDTJOFOGRqdphdtFk/GLUdkxDMTmcqyx/QeiDOPPHzYot
         p25t2E3aw5WyjV6TPEsRAoyH5fYtjVmmMoNHlpRpri6/2AK6lqgZL7yGwccqc3IzFNlz
         16Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791067040; x=1791671840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kz9Gv08Ifi67EI1jeifT4K+itNfN1SXPlehL2hJ15qc=;
        b=E98UZ0WKqu9J1ZfgesEm8BTGDH+vJvQ76yWPRhg9n/stPLn7OSC0AwpJolr999yKPd
         DQNf72vwg4f8Xtb23NprOshPFSivIw6SliETHYAMzUPCmoX9dv1qvOirloIvq6YyB7pY
         XydFpALBeVxRuaMRDKsSJCcWq4psEuROd8w5nn6oK1kDN/WiWo9KwLI0Ccswgen0cayL
         Mmkxniy0QU8UTzrH2XckZuAPTJt3kyMGeFzBa7P5QGUWc3OfELqntoyjKPWHrn6HQCRz
         8Wb3EZLKWvdKP5vuBTji6xeHgflIIrBPYiHE1JG6zIQDfBq94DCwT/BBa9jv+E8sBI32
         ajLw==
X-Forwarded-Encrypted: i=1; AKwUvBzi6r3CiDJmYbRE1cp+SQWycj30YrXWHUrxHUCdtslFJgvVz2DN1VigEeD3VLZ7i/qhfkdVxNhFbqI=@vger.kernel.org
X-Gm-Message-State: AFuF++kIXjvMm0o1c8bzmvNT7jA5QMXpjEk06VyFSsymN3P6qcOFZUFW
	H75fRlCc+08erP8pe8SLlLwK5JgCgnuKXER03SIoUwyqT4brh7wHQtBu
X-Gm-Gg: AYBFou3848NiZURQt2LQ5izS+CPgUyLu2x82FrrBe2MUiNn+idgcpv+o0x0MTUExcF3
	RI/P9HOSySofog058z+K5GJK5/7up2oPA9WHXBhPfs2X0H24wI772RyOblJuOSarkz/W6EyKpr5
	/INHuSqY8w6IZU+hFC3XeeLb//FSWqDYDAtgi+7wBnMvY0zAFWhz9RL/igl9QQMkqG+4Vb2gDz5
	m6Ofmns2if46auHOfWPVp4wXv4xBBhgv4ztGGp52dQzEt4Su7hqLQiz69ZHGFxHlatAq/EmM9sA
	WJyBEkxdXp2IaKjJ9SF+3Xe6YztHjm7GH825JJMk+lrRnrxETJhYIugVDeEYOoq1n9dRKoYtnZF
	rJ5aqzsahd0RCP9bBkd2s51aHZWcJoCBKJ8GQtlcC83WV9tfxLWakulcsd9KZCAGwKggqhwJ8mw
	vuyPdvqj15uHLXq7i8wGyd/p2m+9dLohgML0aIYo44Kdb7Jd82ivoaHCkSaNYzkNSJ3rczZF8ES
	tp2EcKLZPbU8L71oHAJB60ELu9mAqYVIPR9p7ElQ6iVhVVRVVPZhhAEkMtZKAEJtIXI01xDGBtJ
	e0Wv7DEULs9TBp3t9Q==
X-Received: by 2002:a05:701b:2516:b0:144:ff51:2d73 with SMTP id a92af1059eb24-14f5b11e751mr11364239c88.2.1791067040090;
        Sat, 03 Oct 2026 15:37:20 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.98])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fa751693sm21283370c88.2.2026.10.03.15.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 15:37:19 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: miriam.rachel.korenblit@intel.com,
	linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	helgaas@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	emmanuel.grumbach@intel.com,
	nika@nikableh.moe,
	mpearson-lenovo@squebb.ca,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless v3 0/4] wifi: iwlwifi: recover the BE200 after D3cold removes its power
Date: Sun,  4 Oct 2026 04:07:12 +0530
Message-ID: <20261003223712.14003-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1789333511.git.navonjohnlukose@gmail.com>
References: <cover.1789333511.git.navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Miri,

Ping on this series. It is still needed on 7.2.8: when _PR3 removes
the card's rail in s2idle, BE200 (and others) comes back reading all
ones and Wi-Fi stays down until reboot.
