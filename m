Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E23191D0
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233012; cv=none; b=eRMY5G/1YTb5YBtYNhdzFkTdbKLVTDO2RoG1Tb6lYuNmEduOWiEd1hk5cmyVoS38xZENwnIlCJA2Gul4g4G1TCvkR53ZjaJ7v3tJducYCVH5HAMBLFP4mGluiEgimInPNFMF3XTTCyYYglubw5Updq9gyKgcNK1wUJaCSdWfC5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233012; c=relaxed/simple;
	bh=IO3IaUu1uKZodchtwQMhsQsxdlAFl5DLnFq9KPo2zhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBSoQ1//dLsOt7o5qRIuTaiEUCWGd8wLZus1mBtQHOU7cik+74heqatBcyF/EVz59YsBwlgtU2/EOESdhvivL9S/KK1Q6uaYRTGRYwqUkz3Rw6BOp7IDbv9vevQv4XFLOnH/mPPxu4eqICGx+YhxLiRQ6hH/kICpLRIAMPRCKao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cdl99HR3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cdl99HR3"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c73cefe192so62375ad.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782233009; x=1782837809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rUCXLhb0bwQI5jAi3AeGaL2pacxrrvJDt+WvFjr4LkY=;
        b=Cdl99HR39ZuMN5pAxlyTpkTp+JYMHqFOLaZT6eC9ydbSpoNDo2TtWUofubD4GOK6zr
         S6pk3SpVtH/5m1BPz7Q6hHO0sprLfoUOtSsPtUJLs7l4HvILulka91DehDl9Qu5FkNjm
         nzWe4xPUeS3anFsM7Kel37guFGY1+wwYFgxRrXtMXF4GklhmFqAvW4FnhXqPNNLuC2MC
         /KHU9DUVXDvP6dLBNsdY1kIYoeJlu3SegQzxlBE7MHK17R4jMlnFLY5Jnc9ETFFEk4jB
         6wAvKxLGiNONuDR5EAkEoVUBS1Y5tDuPIhoO2MMas9sukdUoMfEjavjQJv4X5uyTW1af
         kG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782233009; x=1782837809;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rUCXLhb0bwQI5jAi3AeGaL2pacxrrvJDt+WvFjr4LkY=;
        b=S+cHe7WpKQ9eKe3+cuh52YJaAAw29stI4dAN9RPCreO9gTdyNrXNicaNww8y2egQMM
         OgWoFc8Mopcfsas3NYPhSgNhtpwBx7+sjBwbFnvxJJBGxGaRLMSE5LC64QOczZh7zTu3
         8P7iuA53QrvrbkhyBar54QTp7XaFct097KLaC6K0VuQY75zhoC+g7hew4YGfzR+u5b16
         pnTPHMvhlCc9faJh9uDKzGebThisC2r/iSYR5AV4SJZKpjo71ueMhFXjV8Lz4A6oHRcE
         0m2zpY2VURl5fSXohxkfn8ZwkAbbGYzLODl2PLRgrFp6HiqsDy/cJyS0GNonXgRz5UQv
         xSsQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHQzsyZBZQ3cwmbuoESsPGC/MQoaAu0NKoBClnMqfojrpVhCIPS5uGhwSbcIEoeRCZDjDsmsqyJmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywf+O1/F4tHXYDglHgOOihcFzqbW3ldYNIWRxfoVcK4hSsjRLL
	Tj7329OZnR5ypvWsDQrl4bdOYA9C6N91t3pn5++m/bb7n704ts4LcZ4syRMq3azeZA==
X-Gm-Gg: AfdE7ckuyOk/05UeOakoxRI8kS8wMY6DfY1QLiKThJwnZgrpWuexcILffC6kW4gnlVM
	N/9HIngcIlqFe3ucRWSu7FiNXCic3OzDc8G9wVNYMAszz4cWMROe2x5dm8Xa8jpK/bJh+awDyBs
	06ReHaxE5lbo6MOKYINiV3X9Ivi+fP8vPC4zVMNsLa5+WS3uXneIXWtzeWUYa8B/hoTYLOrucw7
	6O48XahywJznzbHjhucP7Rnf279a1i4iEJcDhcNADFpSSU++yUL4SRrGGH5SS0SQsaWHJweIetk
	p3jbTCgVEXpK2AIfdou6XWHwLBoEBSIIRqczPEUILs+BjWO9GyllO4VyEoTyZvw9xP9iVkWE0OH
	P98wKdsGKHRjytw6X+YU17JQQ/FGf4ZGYJjEpU1cPyR1aQ78qt1Doy5AmtXMJry9HVFNImYrCV1
	1oy7ffDWF2F3lgvHptIpmrWQU1uf/0iW02VvoN51z4D03eWg0VHIhrqhJqd39Dj5V1pyxjrWrai
	hIx1dr7
X-Received: by 2002:a17:903:320a:b0:2bd:6dad:7ccd with SMTP id d9443c01a7336-2c7c7118b8amr2140445ad.25.1782233008303;
        Tue, 23 Jun 2026 09:43:28 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d6c5dbsm10669159b3a.12.2026.06.23.09.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 09:43:27 -0700 (PDT)
Date: Tue, 23 Jun 2026 16:43:24 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 04/12] PCI: liveupdate: Document driver binding
 responsibilities
Message-ID: <ajq3ohoU2hJfhsp5@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-5-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-5-dmatlack@google.com>

On Fri, May 22, 2026 at 08:24:02PM +0000, David Matlack wrote:
>Document how driver binding works during a Live Update and what the PCI
>core expects of drivers and users. Note that this is only a description
>of the current division of responsibilities. These can change in the
>future if we decide.
>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> drivers/pci/liveupdate.c | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
>
>diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
>index 96c43b84532c..4f2ec6ffdd16 100644
>--- a/drivers/pci/liveupdate.c
>+++ b/drivers/pci/liveupdate.c
>@@ -70,6 +70,22 @@
>  * preserved. These may be relaxed in the future:
>  *
>  *  * The device cannot be a Virtual Function (VF).
>+ *
>+ * Driver Binding
>+ * ==============
>+ *
>+ * In the outgoing kernel, it is the driver's responsibility to ensure that it
>+ * does not release a device between pci_liveupdate_preserve() and
>+ * pci_liveupdate_unpreserve().
>+ *
>+ * In the incoming kernel, it is the driver's responsibility to ensure that it
>+ * does not release a preserved device between probe() and
>+ * pci_liveupdate_finish().
>+ *
>+ * It is the user's responsibility to ensure that incoming preserved devices are
>+ * bound to the correct driver. i.e. The PCI core does not protect against a
>+ * device getting preserved by driver A in the outgoing kernel and then getting
>+ * bound to driver B in the incoming kernel.
>  */
>
> #define pr_fmt(fmt) "PCI: liveupdate: " fmt
>-- 
>2.54.0.746.g67dd491aae-goog
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
