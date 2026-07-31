Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D4B47CC92
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523644; cv=none; b=jl013FaiIJtrOAqGCXQ/QjJ+pd5P1B1Ek7VPZ2mf8cEzoBu8x95h+1Q+9gNh6EsBOoYmAgyR3ZKmo0iLxTK3o1x7Wurc323o+O/Q6ejZE7p75MbyfT4OQvcrxaDLCv99/6+amuZOajjeuFDM1/5CTWLTud+C6J6GS/Fnb9MAQ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523644; c=relaxed/simple;
	bh=y59G2FpgqvwaNh/Ji/eIwgseaEOlWwVWrc3yJTqbcDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUx+BEmBAPZFYng9cNeJKHnzo7tdcNe7qAC+AAgCfOVWQpee20HPtHXe9p/FC8FL3pJxy7BErczlR3TjNzfheLgOVhW92fyLj2Sd5BNvCsgN6xucGwUrDURywyxNA6pYDRwFEl82EARGRENHo9ECMNaXOOGl44GjySW+Nsj9+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id C8CE710616;
	Fri, 31 Jul 2026 20:47:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AF50E60DFEAB; Fri, 31 Jul 2026 20:47:10 +0200 (CEST)
Date: Fri, 31 Jul 2026 20:47:10 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Yury Murashka <yurypm@arista.com>,
	Matthew W Carlis <mattc@purestorage.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Qingshun Wang <qingshun.wang@linux.intel.com>,
	Yicong Yang <yang.yicong@picoheart.com>, dio.sun@enflame-tech.com,
	linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Terry Bowman <terry.bowman@amd.com>,
	". Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Arjun Govindjee <agovindjee@purestorage.com>,
	Ashish Karkare <ashishk@purestorage.com>,
	Jasjeet Rangi <jrangi@purestorage.com>,
	Meeta Saggi <msaggi@purestorage.com>, rhan@purestorage.com,
	sconnor@purestorage.com, an.luo@enflame-tech.com,
	fernando.hu@enflame-tech.com, bill.wu@enflame-tech.com,
	xin.wang@enflame-tech.com
Subject: Re: [PATCH 0/6] PCI/AER: Support Advisory Non-Fatal Errors
Message-ID: <amztrrIGvz8gPxQb@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
 <20260724223903.GA1073029@bhelgaas>
 <amdnMg_J6T3Sys45@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amdnMg_J6T3Sys45@wunner.de>

On Mon, Jul 27, 2026 at 04:12:02PM +0200, Lukas Wunner wrote:
> There is one other sashiko finding I need to address:
> 
> It complained that in the native case, Advisory Non-Fatal Errors are
> reported with the same loglevel and ratelimiting as the accompanying
> Correctable Error.  But that's intentional.  However in the Firmware
> First case, I got that wrong in that the loglevel and ratelimiting of
> non-Advisory Non-Fatal Errors is used.  I'll come back with another
> fixup for that!

Below please find a fixup for this finding of sashiko.  With that,
I believe I have addressed all sashiko findings which are not
pre-existing issues.

This fixup is intended to be folded into the top-most commit
on pci/aer.  If you prefer a proper, separate patch to apply
on top of the branch, please let me know.  Same if you find
anything objectionable in this fixup.

Thanks!

-- >8 --

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 2a380bb9bfcb..dd2aa5dd4dda 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1028,13 +1028,15 @@ int cper_severity_to_aer(int cper_severity)
 EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 #endif
 
-void pci_print_aer(struct pci_dev *dev, int aer_severity,
-		   struct aer_capability_regs *aer)
+static void __pci_print_aer(struct pci_dev *dev, int aer_severity,
+			    struct aer_capability_regs *aer,
+			    bool ratelimit_print, const char* level)
 {
 	const char *bus_type, *sev;
 	int tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info = {
+		.level = level,
 		.severity = aer_severity,
 		.first_error = PCI_ERR_CAP_FEP(aer->cap_control),
 	};
@@ -1043,12 +1045,10 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		status = aer->cor_status;
 		mask = aer->cor_mask;
 		sev = "cor";
-		info.level = KERN_WARNING;
 	} else {
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
 		sev = "uncor";
-		info.level = KERN_ERR;
 		tlp_header_valid = tlp_header_logged(status & ~mask,
 						     aer->cap_control);
 	}
@@ -1067,7 +1067,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	 * For Advisory Non-Fatal Errors, record statistics and tracing
 	 * even if ratelimited
 	 */
-	if (!aer_ratelimit(dev, info.severity))
+	if (!ratelimit_print)
 		goto anfe;
 
 	aer_printk(info.level, dev,
@@ -1094,10 +1094,25 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		if (anfe_status) {
 			aer->uncor_status = anfe_status;
 			aer->uncor_mask = 0;
-			pci_print_aer(dev, AER_NONFATAL, aer);
+			__pci_print_aer(dev, AER_NONFATAL, aer,
+					ratelimit_print, level);
 		}
 	}
 }
+
+void pci_print_aer(struct pci_dev *dev, int aer_severity,
+		   struct aer_capability_regs *aer)
+{
+	/*
+	 * Precalculate ratelimit counter and log level so that Advisory
+	 * Non-Fatal Errors are treated like the accompanying Correctable Error
+	 */
+	bool ratelimit_print = aer_ratelimit(dev, aer_severity);
+	const char *level = aer_severity == AER_CORRECTABLE ? KERN_WARNING
+							    : KERN_ERR;
+
+	__pci_print_aer(dev, aer_severity, aer, ratelimit_print, level);
+}
 EXPORT_SYMBOL_GPL(pci_print_aer);
 
 /**

