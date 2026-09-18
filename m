Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A6E51C33D
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755357; cv=none; b=oAGXSkqFl83Ji8de+kc7dQqYwaEv/q5HZGQ5OwhYDgHmsM+1advA2lXqeDrAh3xzidGpUM5pzzIThtHCDhnLDJ2eT1X8x1eOE6PShbKYSN1GK1/JFh32c4xeNlWTfl8YOeCZ59Ii4EQPCDFiS4WEl7muY2EcMBUtD4/fnUKudq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755357; c=relaxed/simple;
	bh=OW/egmM7mt/va5mQ7VY7PztEIbg4lcAaL2bbHrTbTPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cH2rVpXZwRBqQMgVCZUscjxvTlk5awU1TNb6TEAZqAXlSyr7gilWNFcvQlab/r8t0gISrWPER04kC8/qAFCbTZ0FNhqdl9P9I9VONH+YaNK2tzNrk53rmATxeh2CXWNwi4VJLyIYSx3AparxC5M2Wj8mNbLVLxNNJjbmotuUL78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YdcTGLxk; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YdcTGLxk"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so1768732a91.3
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 11:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789755355; x=1790360155; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OW/egmM7mt/va5mQ7VY7PztEIbg4lcAaL2bbHrTbTPE=;
        b=YdcTGLxkxlZi8gNpmY5tjK9DZdC5iSaM9lHUXPIzh3mQg0ZQFZ7eJp1IWrhzV5jkav
         Ib7uGMOdg6zA6aNkLemrtHSCu+IKfPQCkrXa/LAk8a0MBtr7EwvHcQKWKUp0mG30c+NJ
         TahKQ/tIx0iphsg/JJxqjWzn1G6DQRRmJmHh7RePSOQDFK9Mr8LpRBq8K5qLJaAUIXt2
         ateDWYELUv7xbccRIac8RR7bcviBC37xneeFr6xIbswqx+9lMUer6nqbOMFVAaWDaiEJ
         bmPIpbKJh/t2CjH59eVYKRjeC3bzpZ6X4ZR6RVWiT0tdO1Zzs3ONUOk1uHnHy3jH5Gzq
         oJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755355; x=1790360155;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OW/egmM7mt/va5mQ7VY7PztEIbg4lcAaL2bbHrTbTPE=;
        b=ln/eQHmvgmHf7ZrHifiXaUX7pRsYv2qFmSJoJPv0tnpEDR+pEePhWuL6fqpjCXoamo
         O78RXvyGFCiJO6H46H4hgvenTBJwXNjo1/Mxrl3eLVmFvRlsd+y6Xv2Peyq8NGr8dnOi
         JKLikh657md8GUIETcVoTzdZNV8RYYi7j9SeiJAp5LgWKsT3aypPnRJuJfEZdqRFTcWO
         ma3k62iIKGxx4If2udVUo31OoZnFo+yyu5ptLX8jWbfqeTWzkhAGuAHsP6yCTwlLhaAS
         dk7MxkRj2Us3y4OY3Pl+DWkI0w1OWBnyhLxN7HB9u3pGtcWkO8FBK4jSw69xf53HtqD8
         NFYA==
X-Forwarded-Encrypted: i=1; AKwUvByAFrd4Tu00mFPxNzzWg4F/0RKSA/CNtLI1MVx8SmDFfBdMwdgerwORuKh7fqq8ON9Zr/NBFxm81qg=@vger.kernel.org
X-Gm-Message-State: AFuF++mRcwQBOxsC169In3mCTqnQQblhrprjxWG49FNTI7OI29DZ7uXd
	Swdfecuk9DBTHQOh44BL+e7+5M94sQLnijYVDhshzoEN8On7xqQ1IF3fQh1wK+5j6IdQnr3ZmHl
	P4k9+YvSbX1RZxTmwU6AE9wKEcmyS06fX0Q==
X-Received: from pjbiw4.prod.google.com ([2002:a17:90b:4204:b0:39d:a2e8:6890])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d40e:b0:39e:6c6a:656f with SMTP id 98e67ed59e1d1-39e6c6a6787mr605040a91.50.1789755355148;
 Fri, 18 Sep 2026 11:15:55 -0700 (PDT)
Date: Fri, 18 Sep 2026 18:15:54 +0000
In-Reply-To: <20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918181554.132414-1-rathodpriyank@google.com>
Subject: Re: [PATCH v4 0/2] PCI/AER: Fix ghes_estatus_pool memory leaks in
 error handling
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="UTF-8"

[+cc Kuppuswamy, Jonathan, Ilpo, Dave - you have reviewed most of the
 recent aer.c changes, so adding you here]

Hi all,

Adding the reviewers who have been active in drivers/pci/pcie/aer.c, as
this series has not had review feedback since v1 (3 Aug).

Short summary: ghes_handle_aer() hands a ghes_estatus_pool allocation to
aer_recover_queue(), which returns void, so ownership sits with the AER
code. Two paths drop it without freeing - kfifo overflow in
aer_recover_queue(), and a dequeued record with no matching pci_dev in
aer_recover_work_func(). Under a sustained error storm this drains the
pool, which then breaks GHES hardware error reporting system-wide.

v4 adds the Fixes: e2abc47a5a1a tag and Cc: stable that earlier
revisions were missing, and is rebased onto v7.3-rc3+ (applies cleanly
to pci/next as well).

Review feedback very welcome - happy to respin in whatever shape you
prefer. One open design question I would specifically like an opinion
on: patch 1 frees the buffer inside aer_recover_queue(), which bakes the
ghes_estatus_pool ownership assumption into an exported symbol. The
alternative is to make aer_recover_queue() return int and let
ghes_handle_aer() free its own allocation. I went with the former
because aer_recover_work_func() already frees unconditionally to the
pool, but I am happy to switch if you consider the exported-API
contract cleaner.

Thanks,
Priyank
