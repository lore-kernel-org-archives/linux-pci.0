Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DFF35B631
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769721942; cv=none; b=uuXjY9P+0Ja7VRmz3MNO0oL7WK2id6547Catz7yfCjGaKkzN2/yjeexsLvRgGGAWMUsqZfrM/3CG2uX8T6xvQB9FonbtD48M/IiSz2LC4Q16DPw0wSdqWhF0KBnF0VW+HODnctIZrDPoRWm+uCJG/EfjQAQXPY26V6Hv1xmtJqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769721942; c=relaxed/simple;
	bh=pGh11QoBfatNNPcD3UbRdXhxdT0MMITx2WqEtn8eFss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rLOB5n/9onikf2jEtHD4m6B1FVUusa5RUCke0UOMC7SJngoW2xqvBCJNcGfBQ7r4kMnkLZBF7aG2nAcuyE/L1+YngfB2k2IX6pUzJf63Mhym4WN6rKLYgpbXwWuC23z1VYnbu28H6n7s01+9hAiDbcTwTHeVFpNLKiqikpgSuJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YgClsBSQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YgClsBSQ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34ab8693a2cso2888700a91.0
        for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 13:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721939; x=1770326739; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iXsfpp7fYjSPi1nIw2ScrDnrjqTlWGi7ZArDWIRjDgk=;
        b=YgClsBSQkemOJVm7JMV99ev6GYocZTi+wpSdSxrIQAl42Bql7Vr4oGTqoEtm0Hz9vX
         24FOanK/YWsgGM16o/756RCi/TOKqOzj6j+/XBtzZ6F5BPmRulnQtrHlb2JCAgnW64xI
         wNDMI/jZXzuZhvw5/SCsFa8VhoGxUbJKTZNI+6kQ30ZrMLTCUyccCV5JxCzWHXbKh3JW
         Q2FnBxQj9+z5NNXKrQFB9QPKJiGtxr5vgr5VXI9hJjIvAQXV7wmRW9xO9nrwSm3foyaO
         u23daigvanFsWEXNf1FeMaLkRRSNf4xQ68YAVvzmWfN9o6GimsOztC2hSdEGDi2TCgLu
         3L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721939; x=1770326739;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXsfpp7fYjSPi1nIw2ScrDnrjqTlWGi7ZArDWIRjDgk=;
        b=W21Ks/CHSzusCZVgek2iW5Hpj1YaoxME82RDN/CPUeZQBx9QS1nP6pOpGgln4aZo1j
         bPyvX+OX8fkx4dCaY7EPvry594NRjOo2bqqkJB0FWAW17u5vFUUdeMooPvC+itBasvCV
         Wfsq+aG0ygnIG0csv2vPJcZECKNC2X5RFbVZeVpt2KYQSqDfYoUwWgpSt5VUMHNPssWp
         4PJvgfYavPAVUpoVG1EztPxQobEQb9spcBO1y5Bx5JfWq27vGcZzDKSLtJ0cG0ke9S59
         JBqkrjqqqgo6p6kggGe3Ti8dQz2BIo9I0Zq+bkd1zgGK5JhN/DFgquS6pP1lwnwSTt0V
         pL0A==
X-Forwarded-Encrypted: i=1; AJvYcCXJgjibJ75XQKF/j840S01MDQGpgR/CzHi/pMPgvpu0ue6P9D+Cq6MDTQFLYZSO46lKq0DIYxnk2d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyeEw8bNQqb4/7tq4E60kpH6jYL9bid0x2XWyNZWg9pzG4buHB
	uwKAOao2Tfu+L2cLq0iVKJD9odm7Nu85WeJW5LFxLfR9xDaP5RZplX9Yll4Q6gHDtkYQ6lvb2ls
	EqqLjChmtdtanCA==
X-Received: from pjyu17.prod.google.com ([2002:a17:90a:e011:b0:353:454:939c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17c9:b0:353:356c:6840 with SMTP id 98e67ed59e1d1-3543b31688fmr768863a91.14.1769721939368;
 Thu, 29 Jan 2026 13:25:39 -0800 (PST)
Date: Thu, 29 Jan 2026 21:24:48 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-2-dmatlack@google.com>
Subject: [PATCH v2 01/22] liveupdate: Export symbols needed by modules
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Export liveupdate_enabled(), liveupdate_register_file_handler(), and
liveupdate_unregister_file_handler(). All of these will be used by
vfio-pci in a subsequent commit, which can be built as a module.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 kernel/liveupdate/luo_core.c | 1 +
 kernel/liveupdate/luo_file.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index dda7bb57d421..59d7793d9444 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -255,6 +255,7 @@ bool liveupdate_enabled(void)
 {
 	return luo_global.enabled;
 }
+EXPORT_SYMBOL_GPL(liveupdate_enabled);
 
 /**
  * DOC: LUO ioctl Interface
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 35d2a8b1a0df..32759e846bc9 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -872,6 +872,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
 	luo_session_resume();
 	return err;
 }
+EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
 
 /**
  * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
@@ -917,3 +918,4 @@ int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 	liveupdate_test_register(fh);
 	return err;
 }
+EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
-- 
2.53.0.rc1.225.gd81095ad13-goog

