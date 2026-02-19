Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E632AAAF
	for <linux-pci@vger.kernel.org>; Thu, 19 Feb 2026 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539031; cv=none; b=ngo00e0bQYN6cSnq21y6nnvxk9fJTEhYlA09y5iMG5Hk2OlWKP/9SkyXA1mM6hVSuDN8Az5MlkBe5Wl4p55/8y+6CmEqSR6QYSuUJtSVy7cJv7pGzoPWoshnubN+KNUp8GU+SaIvyGEMz0qKSB0UYY8wuR+ZIC7TnBcMe9N3PHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539031; c=relaxed/simple;
	bh=tvjo6YREoPXGkfdT+8T8KpbpJ8V+nnWXdCE1HZOHry0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkDiYZX/ATH43EY/O1LkomP5sY2wNtF6zQvbvFx6ZUHe/qSRhnyepSKTntdvjRlVLdJE8UZvF0RQFhsZA5tM7QbqcUv9ligPl6RZffZwiBZesqHZGw/HFTv/FPkqnuMyXfIVWaphaf6Dy7uo+qLTs6aNMmeoQnflfMN7NPhYxUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IFEMThtE; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IFEMThtE"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ba895adfeaso1466362eec.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Feb 2026 14:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771539030; x=1772143830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htR2cKXbmE7p8X2oCaV5WAydK1PmqVneZFKmCe9IrrA=;
        b=IFEMThtEc/BdNcZ4RhXqegzxlcd1BqsqK/Qgqhc+7Pw0E6tNwYDY1SrPW+O7jRdtYS
         Yk2acCi0VntLzRpo2+C3TzX2v7qeVNPYKf60bMIXSW1TB0bZF8TFfXD6QtAc6Aa0wPFH
         Ew+BBqKp1iB6g9T2p2aTbSUWJNJzePH+eW5Nk4OzZ0wu12DwIPKWhWTSjxyeC4ToCZgQ
         gXXcBqx+WAcUk5TNBzQd6OleUI6tM6HPxW5JIGp08Q+02Ctvju4t+D+U4IH+njHzbWRN
         Aw+7+JYVvvMSKerijb4v9pmY9fZ12nPU4hPSF3DfwWAEa6ObA2mVty561pgcku3RD+YA
         V1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771539030; x=1772143830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=htR2cKXbmE7p8X2oCaV5WAydK1PmqVneZFKmCe9IrrA=;
        b=KqY7w0cqm09v9xd2fZkVFRT/OXGrGF+WcIoQyjzL4lZKhgssJ3DXBJvI1wqCNDZXUl
         2xua882WZc79JqtlESZn03L6TqkXYGTLRgkCBVc29EJ/dUEukwG+a3wbYE4eASPNnY8i
         0Ekd9Xt9Kh2vLDSoaOU1XHd6JYyTlTAQlYKzonA+9C9p2Mia8yguHoWUZrskdboNKfSY
         NKJHhE2WVsND11+SoAaZx79bwgolclLEQkGo/wpCQoIJDi5wQGCtK5qka4qy2iCHfwKc
         n4IyvCjh+tUdfWz2uxKYF/BMQaFMYPKygmEGonegn2RijTNBfHo2WT1WsLqVd4LpDpY3
         sX7g==
X-Forwarded-Encrypted: i=1; AJvYcCXqfsRJz+98u4WVzuReElsDx/jXn1f/Mb05l/5TBX9usQ3CRTMHMVhPUXVSwjXuwguO1edK9KwZFuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOCu8qr+RJbZJMYZz67ql2cOuk5zbMiaLs7FzT8t7NABykC+kV
	6A439Q+cZQFT8h2bnFJ3hLMZ+wiLLQCjr4s/G9fWbRNeeA4w8HqBUos7EiRJDCxLVnM=
X-Gm-Gg: AZuq6aKnzo//TIsXkQ8pevzf3ej74T454iVJMM9624cA5RfNgItnVL/E50x2yN0D/eY
	whnQHuFbJQNXj/+DyGcF3pAC2AajkSypgta8uGDSryi1iCsEMrT7goCB026jyGx1+q7XMvRDIS9
	Zd9KnYXlXYeGClYeFsCKi7yV1surNzddtGaJOOKxgzpDAFeIaaghXN9ECbQCPDCynmMFjfE3A6x
	XcZ1+PLGptotMilyXzhSWDZngaHtLowTeS1Fb8ZYxB3CPmef3rGw1u480YkA/hkXWqfNNsAFbZE
	26PCsMLyIqe7nLcWfEzBXrv0KSKTaEbcZ+yQFMCCxo/itCSQfjUtE49SGizp4nqQ8V/UcknVObi
	ikdhdu8sDusAGUjZqHbXRfOt8vIKdoHCjIW0uLt73iSCrFDDJDNFoOQrRJJRgDpPPokV/oTNBjD
	ampvz+yKL01LYQDz7tUqtSavQo4S3qm33HKok1XEvuMzfyIY1ace20ytAoSGd7Bmwelxc73SVJx
	PESqt7Rx5OOV3SfjmIVHGPIfOrrdY4+gVXqguY9S0HqH3bHW1I=
X-Received: by 2002:a05:7301:6884:b0:2ae:579d:2038 with SMTP id 5a478bee46e88-2bd5003727dmr3955779eec.4.1771539029464;
        Thu, 19 Feb 2026 14:10:29 -0800 (PST)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2bacb543d40sm26735057eec.2.2026.02.19.14.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 14:10:29 -0800 (PST)
From: Matthew W Carlis <mattc@purestorage.com>
To: helgaas@kernel.org
Cc: ahuang12@lenovo.com,
	alok.a.tiwari@oracle.com,
	ashishk@purestorage.com,
	bhelgaas@google.com,
	guojinhui.liam@bytedance.com,
	ilpo.jarvinen@linux.intel.com,
	jiwei.sun.bj@qq.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de,
	macro@orcam.me.uk,
	mattc@purestorage.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com,
	sunjw10@lenovo.com
Subject: Re: [PATCH] PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining
Date: Thu, 19 Feb 2026 15:09:59 -0700
Message-ID: <20260219220959.19900-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260219212602.GA3498590@bhelgaas>
References: <20260219212602.GA3498590@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Feb 2026, Bjorn Helgaas wrote:

> Applied to pci/enumeration for v7.1, thanks.  This will be rebased
> after v7.0-rc1.

We're heading down a path here where we keep working around the work-around &
now have decided that the kernel will be meddling with the link on potentially
all of the PCIe devices in the world. The trade off that we're making here to
accommodate a device specific interaction doesn't seem like the right direction. 

Can we reconsider my patch that restricts the link retrain mechanism
to the specific device that created the work-around?
https://lore.kernel.org/all/20250702052430.13716-1-mattc@purestorage.com/

How do we decide which device to fix and which devices to break?

- Matt
