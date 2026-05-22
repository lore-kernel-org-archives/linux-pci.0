Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857833815F7
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779481457; cv=none; b=LCXUwwIpeuR5chca3TgNfvwmMLWZMSxITAlw0EJiUqReTGPqLVf7AYLn0TeHHHpEct0+QIB0yel825+dY0Ksv8f/Jv5ppfE01mgmlFeUtQAq+fN4mDozvR7vIeoUznuJBwS/TewzydLyB/UqE8oMq1FXarB4nV1I0PCPn2nQBII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779481457; c=relaxed/simple;
	bh=YRZsIIO/eWIDHTrvcJinj7ZXVV78Jb+4bEPHJAE5AyU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HkKBsuxTKSdARnzeXOMzCPIhLFh7WWvLzaWDXipSkatlypxh29PsrSwRuIDPN5OZdFZDCjXbPYhV8hPTsEnWbHTAU68aJuNH+v4qmJcvVYaS2t0mW5mLi9lBMEq1An9x+Qlvjm2EHrzg8FqHvfVvujF+RA/gLX0ppL2D3uX9YvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kti41HZI; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kti41HZI"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-367fd7b8825so7642708a91.0
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 13:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779481456; x=1780086256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lI5mS1q2qOObabKUBbKfb1QQJkZ/uNYoefmzXL5rBmg=;
        b=kti41HZIqxt2dZcw2LHqWpyzMDaystJ57HkAbu4dtrnm7ohTA9MnoQ0uUEjpXV7OvM
         KE+Jf9lZotZOwg5FoMZFVU7qJlWm6/i8Z0vcaNrpPSi3F7yNiRzqGtcMasvFKoVj4S8F
         njg98uUxLdVD8qOrn0RNgJcdlrDZFt1pcVkRsWPO18xcnvDSmSx/Acu6OcA3vIqyHseS
         b1NoCflQXVnYFCrSjnjaxVZVf8Y4qxioaMFojqB4ixhc0a8zC++txvhrnNBTHvN2NE/b
         cFAwQiH1kydblogUDCL2hbojgYtHnZW21A1BnmvI0AYF9HaoHPjaTptE8SVt3wTtTkvd
         XbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779481456; x=1780086256;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lI5mS1q2qOObabKUBbKfb1QQJkZ/uNYoefmzXL5rBmg=;
        b=JbmPASmHC7DVu44bdpDiZeK6j+dDMSfJOwosWpVwWo/HQiUKdrKWRsCNjfisAbYhzZ
         2NOdvxpW3sGJl/fUwhPthwK5S25BIxYL7swAcU5qTOt1uMqvlp4F7TXQ8w3XPiRZXi5R
         kKCejoOkUbt2feJ72kr1EXj6sHKPz/eBvMZnG66HZcHQ+faW9GLZxsqMiBm5FcGEyaCp
         WhzLfHZlP/DtMR5dV2Jlhm+xMGWzMuV9Okv3BMasPg4ArVHanp/wUffeNf8fUN1A3JSE
         Omwfz6q6xYxhagyxaUrmS9vsgV3txhaJTaSJpBgCUQaOco0ritJELSxOavLXtysBV/xw
         KcJg==
X-Forwarded-Encrypted: i=1; AFNElJ8RJT+GCLb2dY3iYMs9RKuroM/LvAa7Xp6YDcBxBPk9/fFR1UPFVCDNnp84bk6LjoS+qiAaZ91Mf3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw467C9JmZUt62oK0As0cZKbK5ooHLKfEPXnY7dt47/5ODBTRV+
	vsj14bWiZSjDspmTgxPdDQmo13OIZaBwR5lWAf8G6kzSBu/qi1lJEOKlP6UDJccJOmqbPd3gDc5
	Q7jTBUDLPUQdkLw==
X-Received: from pjyv15.prod.google.com ([2002:a17:90a:e98f:b0:365:ca4c:7afb])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1a8e:b0:368:78da:803 with SMTP id 98e67ed59e1d1-36a674f81fbmr5156953a91.12.1779481455496;
 Fri, 22 May 2026 13:24:15 -0700 (PDT)
Date: Fri, 22 May 2026 20:24:02 +0000
In-Reply-To: <20260522202410.3104264-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522202410.3104264-5-dmatlack@google.com>
Subject: [PATCH v6 04/12] PCI: liveupdate: Document driver binding responsibilities
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Document how driver binding works during a Live Update and what the PCI
core expects of drivers and users. Note that this is only a description
of the current division of responsibilities. These can change in the
future if we decide.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 96c43b84532c..4f2ec6ffdd16 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -70,6 +70,22 @@
  * preserved. These may be relaxed in the future:
  *
  *  * The device cannot be a Virtual Function (VF).
+ *
+ * Driver Binding
+ * ==============
+ *
+ * In the outgoing kernel, it is the driver's responsibility to ensure that it
+ * does not release a device between pci_liveupdate_preserve() and
+ * pci_liveupdate_unpreserve().
+ *
+ * In the incoming kernel, it is the driver's responsibility to ensure that it
+ * does not release a preserved device between probe() and
+ * pci_liveupdate_finish().
+ *
+ * It is the user's responsibility to ensure that incoming preserved devices are
+ * bound to the correct driver. i.e. The PCI core does not protect against a
+ * device getting preserved by driver A in the outgoing kernel and then getting
+ * bound to driver B in the incoming kernel.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
-- 
2.54.0.746.g67dd491aae-goog

