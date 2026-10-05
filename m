Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2BE4CEE67
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215156; cv=none; b=eoSiLlI4NWt6SiaQGN+zOW60RDrDsi2GKUr7KssfjhxWT4JCkscnamv0nkVerx7qxTW65WwR2eFkTiUMPyszTMe24z0wX65eObNOFo3b1/UD4hROIYK6TbyohIRDLjnBMrSmf5IqpLONOFGGne02BolcjwBDmueJxlR+mJP2RcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215156; c=relaxed/simple;
	bh=KZIMzSNQ5PyWeZjaT/gpYYDCkTtRb/oLmdPXdsZuR/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N9xW7xiw6gv6q9z1EsxL8umnNFOZcG3Xc0m/b8QdJc0CeRZdfuCmh75ebmUG0qHzWwASrU1uIH1tUJtAaHxZ1TTc8CYysoSoHL5apf2nijMs7xFemR8d9HlnE1V6EN20CL3B3e9jf3FFV8EpgnkCPrdTiB3ICbefdU52k0LJ8t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eV/moQtU; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eV/moQtU"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dbf293831so3371388a91.3
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2026 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791215152; x=1791819952; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KZIMzSNQ5PyWeZjaT/gpYYDCkTtRb/oLmdPXdsZuR/8=;
        b=eV/moQtUL6Zrxl9PxK0o8foQXNnvmgcixjoCNhm+bPWcTo8bM9A/MFhi2+kCVn+znw
         vKLUF6wArmv+20ghPBIx0xYTSQHWkhq+ljMKI+EnqS/x5Mh+OQmSEG71pihYdluqDaip
         aJRlEGFJrehrA9jzx/OV+ij0vAG4ZNS0rtuHWBN5t2BsPEc2KRSATIWz+a7dPOMGdxQp
         Zmp/UxVuwA1H+pcB9GZjK/OW9erBcnkF8cs60XKGbEhMhiKZ7PhEe1F44x2WqKy6E20C
         eOXYZ+9F9t6WwoVmVWfHg7fPGr2FIYX0CtxIkX6OajBcR9ui9Uf4tFDkZWmXAItoL4Mu
         A4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791215152; x=1791819952;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KZIMzSNQ5PyWeZjaT/gpYYDCkTtRb/oLmdPXdsZuR/8=;
        b=OzKjS6l1+bgCOT/5oP2R2D8rAqSfscTHzy1DXC+0pCV1AI+mktFQQpjm4hB38Q6ZkQ
         K9tOca03T5avG3GC23e7Xt2LOnS41hSvgLV9YNZgkUlpiKT5pIGZdgcL/Xn5bnOGoKEz
         /qsvsq1HcOY62fCu25cSKnm6+GYO4bWLHlMyNPEBN82V+18GOCLd5kNatoNGzcJiTZuF
         ZWvF/5MvAvfzDDtWq58vFpvUofKOTc4aDRQgxP54lTMNR6U6xHBAj5l0HdAZDZz98qNO
         ZLqIl4O0QDOa9kyOAlQn5QmEhIOKtWTsuNexwq/0nKaMjdeCZuvhxKvyM4uxa7k+Ur1Z
         O+FQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNwmRJhFzKEqcT5roM9PiaTg7m0onAZ5fhs0BoVwKl8EJ8BNsV7LDC7hhF6N6jKvMbx3bfelZ54ow=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVdIF9U6m2DKVegKfCm5IYy8uEvMDgxhhs5GAYw9+lJ2jRr8uh
	mInW6aHw5x4I2It16wsAbzRZGJ+EKm30Q5o26ZiRUso3L0UvDOau+C52nHUA+HCRtrdw4ZfZEad
	t/PfAXZ7Xg8doGl66g90vVV3UyWfqB/s+VQ==
X-Received: from pgby17-n1.prod.google.com ([2002:a05:6a02:6511:10b0:cc7:d4f0:846d])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:380b:b0:3a7:d9d9:b309 with SMTP id 98e67ed59e1d1-3a7d9d9b6c2mr4026235a91.41.1791215152003;
 Mon, 05 Oct 2026 08:45:52 -0700 (PDT)
Date: Mon,  5 Oct 2026 15:45:51 +0000
In-Reply-To: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261005154551.1508146-1-rathodpriyank@google.com>
Subject: Re: [PATCH v5 0/3] PCI/AER: Fix ghes_estatus_pool memory leaks in
 error handling
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Lukas Wunner <lukas@wunner.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Shiju Jose <shiju.jose@huawei.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn,

Gentle ping on this series. Patches 1 and 2 carry Kuppuswamy's
Reviewed-by, and patch 3 is the kernel-doc comment he suggested. All
three still apply cleanly to current pci/next.

Is there anything you would like changed before it can be considered
for v7.4? I am happy to respin.

Kuppuswamy, if patch 3 matches what you had in mind, a Reviewed-by on
it would be appreciated.

Thanks,
Priyank
