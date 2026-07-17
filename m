Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1957339858
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784324822; cv=none; b=l+1CqzFyfg5nHS57jREkW6i2XstYroj01hOH/kiKhpV0KsOVo6vDvTFI6ANr2wUGtENnsw+smSyNK7GUjGOuHRiZ+rWrjFJW1YMqn5XRlbbSiQdh+ZgPTaHa4HI/y5aFNlFyGFZ5/HDAe7qhY8ON/SQ2q0/ZPQ5SYBPeHtZzyls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784324822; c=relaxed/simple;
	bh=ahWVhQAgslIBwnfpmx5X48jHe/0a44QV3IQwRfGz+iU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=srxDzGmBxhRatg+ChOPIBR5OgfruAdKbLH9k60nfZMYVbciuasfRTewhlq3vNR3QRcrdReHQ9u7nIovNwCt2Jzmp/nYYzeeX+EvOIhfNar/xQNChLhpSc3kK8y6IXRmw5+GQEHW4CuzN/QMJuVXhfoGfis3Hu+7EO9Mbjkg8ONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=MNUHQ6uX; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="MNUHQ6uX"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52192509869so6833821cf.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 14:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784324819; x=1784929619; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AgfKPfkfc4jyNoAXQ924zrK3vmVWU/VwnFCFChfwVj0=;
        b=MNUHQ6uXyAu/5hZqvQhxUjA9gAsaSUkDLtHs9SBhoYzax+b/lnpiChdpccm77YPmzt
         SZU33e6UkkvQEGU05ml5CmnTkmOJwh2gnKlx0wFVW2iMpyK1NK5QeMYAabd9ZPCoDBKW
         8gpfW8ER8ijvXWGJ4QFLhibpVg5MwTq9Yz3Z1o2sjYg2UlYS+6XvEoHgFj7T1k1TRv7d
         QgKWG0Ug4w+QR4yshnq2scoE9AA8YNNY9Fe1h4L4o3XRuU/Z6HkZ1yL6vq2GBbhtZs1u
         /hYEHAERta3W3rEeP+o5Zy6koITetobWCKi3WyBZewYuBqrCgnhZKNDIQQOhUo+caNjE
         yfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784324819; x=1784929619;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AgfKPfkfc4jyNoAXQ924zrK3vmVWU/VwnFCFChfwVj0=;
        b=rRJm0th6otPCE51BFRCVJq4OG7wLTmfFOjPAJgt06G7nQAs90a+gf7SQGjuXC5huB3
         Hbv7ymnHecR6tcgGXsoa4nOvtxnSmJ0qco6TM87AAoBsvpN0bXkEIimkQXSuWmW5HRvU
         UmBypFAIOfpr+om4cBNEltfum6Wi78GIkqJSxyU7YokyghTmoOJybYc4uW1bBMNIMpg/
         vCJXjOWAsCvqC6z5MgUOHyHx6EtEBYcCafEXToFf7vLn9BMvWUEjYKsltTBAOWknGPqp
         wuVrGiYwZ1uIOUy8soXdbPYmJU7mtuxp+OxEYpAi4e3lBcmakXqEwf8pK4kPA4xCCYd+
         MaxA==
X-Forwarded-Encrypted: i=1; AHgh+Rri8E5Yr6t4jaDKMWhNxHgy+EKKK6jprZD+uQ8Zb3nveTyOv8NGLuxYB64B2sbcXvG438aGQ5Un26k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxOm+UrZbN6i1PhnTPg9HWQPR8uQgbBWc1KIiozi364xabWb52
	QjnWKqSCzBFJOF+aYwW548O7SBys7HyYVw9F5t9B84DF91mbgsDqLEwpg0Wc9CXHdgc=
X-Gm-Gg: AfdE7cnWnEWism4pLt9lqA6LbYtk/s6W/DmBMXpQgypKGq7wK/38dHlzMdqLwhmOhx/
	r6If5mDwPokJlL1vp/5CWO0+8xzRK2Pod2abS/P7qsQ3tbwZCFygLO49r97Lh1IPQ35ZoYulzlc
	cjzVlbaLSlfplWlGc2Afsza6z0LU2W++/qasbUGybpCYFOmXNurCi7/HFrMa3SOzg6CXeGJ3xsB
	DcdL3u0tbjtcT5GEw3ZZtPZN+VFIbN53l21KWAhp5duKH/tqpsnt5Fh8o9v5Ewq+Vh4/hxrL00Q
	gCGqiJYfIP1hnKbunWHB37f7A4DWcPmRjaW84N5eAPXr4YmsFE/XjqyD4AN6g2jQwpIdlnsB3dr
	JemSkPHIUw5aszz3/S5D64TIzycRbhOjrq0KDqkEy7zcvpjokGDBEeDaOL36iS05kGZm8iOgR8/
	OGqx5fnCevoZbQhAUQ+gBAtHlQuCW6mCa3KY7JJWepV5mps+zmHA==
X-Received: by 2002:ac8:5acc:0:b0:51a:8c97:fb93 with SMTP id d75a77b69052e-5213fc54d44mr43814441cf.60.1784324819586;
        Fri, 17 Jul 2026 14:46:59 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214c5cc8d5sm21955091cf.6.2026.07.17.14.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 14:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260710212616.1351130-4-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-4-dmatlack@google.com>
Date: Fri, 17 Jul 2026 21:46:52 +0000
Message-Id: <178432481253.189683.3297727348836286619.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=ahWVhQAgslIBwnfpmx5X48jHe/0a44QV3IQwRfGz+iU=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWqLRRsSwqC6u4RSv76ETLMmVCyhdUsVHiqEBy
 IzSCQuBMK+JAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalqi0QAKCRC7dyhM23N6
 3vK4D/4oivNUuZbxrdZZJAOMVjLNn7oaWYDk2Y4dxn2IVLciov4pX+4V8SBAYA4KhEpyZKQ2mzg
 B03dHNIKdFOpoPbLkuTRk9ZGugmK2ChP6tAHjBDG3RkOkva5OLSR6JBKmrLBG2GEATEY/EOLIZ6
 eY/PqU+3F+O6j7iFegvOLxHq4AGPuXSVacvDtCjafit/axJj9LIZ8kF409sq6qgcKO5JKSa8Jea
 R0CHNLN/rrFF9+PoaDcZ3B9yBydtITA6U5LOFg19G95jV2FYfsILSxxBbZrxUBXAadtzCS2F9wc
 ojlbkyeQfKGhVsMnUf0jafSZJy8tlQ5ygLO7zUxGMxHU0yDSH9+T6zwkWpBoVu1DzV6CaJNE61t
 UznWIUm+HsrUwRRGxWKvQ4wAZb7dT86JZoYl//i+SFOHLjV+15QOw7niAqqrMwWfQasB4V2Hxwt
 eXCZu13O9+xov9pJgVNEtvYTQmPpi6xZlCFh5C0RT0QzDoNbZ/WnJZuT0M8/c8BHxvB3E/domK/
 fmKpXprZCKUC0ZMdFx+RiHls3kZs/ypakbVXPUHyzfXsnIT6DxIFfXMfg5kTylkBxQPg2GwLoaZ
 CRH5LGmNRRTuTgY1EFBAo8as9+ZfD4j3ydB1vBG6faS20lFZ3r8fycLqRoy2hUgcnWVKGbkEtVC
 YOLWzX1kCSM2bCw==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On Fri, 10 Jul 2026 21:26:06 +0000, David Matlack <dmatlack@google.com> wrote:
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 03075ce06ac9..df6a02240aa4 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
> [ ... skip 76 lines ... ]
> +	/*
> +	 * Hold the ref on the incoming FLB until pci_liveupdate_finish() so
> +	 * that dev->liveupdate.incoming cannot get freed while the PCI core
> +	 * has a pointer to it. It's better to leak the incoming FLB than do a
> +	 * use-after-free if driver does not call pci_liveupdate_finish().
> +	 */

I am confused by this. Each preserved PCI device must have an associated 
FD preserved with it via LUO. I.e., vfiofd would need to be preserved. If 
the vfiofd was not reclaimed, and finish is not possible, that vfiofd 
would still be owned by LUO, and therefore PCI FLB refcount would stay 
positive.

However, if finish is possible, and this is the last vfiofd that is 
finished, FLB will be freed as soon as the reference count reaches zero, 
which I would think is the expected behavior.

What is the point of holding a reference here, instead of only for the 
duration of FLB access, i.e. to make sure we are accessing a valid data?

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>
