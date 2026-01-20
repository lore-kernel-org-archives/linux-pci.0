Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC147B43E;
	Tue, 20 Jan 2026 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937674; cv=none; b=EScOv2wfaHeP2wlv+t4/cljK1Vaf5aGUxsiLGR0cVBXkPKr2jrTnLmvpNRoSZIxZrRRRFEo9K2Dq56on17L08EtGrLdUHMjxZsvSsme7XnT91/5huARgVMB/wQc8oHI01UObmtRmbJ7QKwA1EkMEq+/OH45T1eXfuETepAbeMlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937674; c=relaxed/simple;
	bh=W7w1uIyJTZzgqaaNQY26ePRzAGuTyZ9aAVbNB2MtmHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j32m96KQo+lMu7STSvcAXDrzrWC/WTozQOzJKKQ5a+5V9Bl6iNEmFrtapjPUrYx1ZpB7D6eeKegCvapTlCcXJdlRMsfOmahpLsHj0nwsXg5+EZdS8jSwLn7SRuGPB0ABuMBZStsQC2JDb8iLR5VMYf+XkcJ6vIJZkrnoDSLl/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvDLHXcN; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvDLHXcN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768937672; x=1800473672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W7w1uIyJTZzgqaaNQY26ePRzAGuTyZ9aAVbNB2MtmHA=;
  b=ZvDLHXcNoNg5T9H4bNHeZgZNOwgQptJF4oBE05rU+C/T9GDZpyjkidD9
   lAnLBF3xCne8pG8ylSzzkZtk1FJme9Rw1CmhhI1gtKinfg5BZVQ+YB6UP
   6+VcICntPsJCnmKrlVpM1t0Peb2F4Fpq+ukkx8ES/B0cLp7IMo81kH34I
   3v+pbpHq7SdCAGiRAQR14mf9jdWZ9a+c7EKP1z1ZpAkmwNFQQRJWManr2
   SOKMIvhOFFncOiON4jaNs3jLsdM5qSvvZylK2/AevgVnWtRV6s55qcElo
   7/doIEkouK3WbokRNVb7Z3rE3sFsDjppsguFmKITfsddVXxfQI3lYFQ2v
   A==;
X-CSE-ConnectionGUID: EPIQa2AoTKK6aq8VW2a24A==
X-CSE-MsgGUID: xRbobeizS1C6s86sUM6MZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="69888939"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="69888939"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 11:34:32 -0800
X-CSE-ConnectionGUID: ifxO6v08Rj22skqXStZtIQ==
X-CSE-MsgGUID: 8Q0gg+AASKuYnjhX6B+RUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="229165844"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.99])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 11:34:28 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de,
	bhelgaas@google.com
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	linux-kernel@vger.kernel.org,
	kw@linux.com,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 1/4] PCI: Add Intel Nova Lake audio Device ID
Date: Tue, 20 Jan 2026 21:35:04 +0200
Message-ID: <20260120193507.14019-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120193507.14019-1-peter.ujfalusi@linux.intel.com>
References: <20260120193507.14019-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Nova Lake (NVL) audio Device ID

The ID will be used by HDA legacy, SOF audio stack and the driver
to determine which audio stack should be used (intel-dsp-config).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 84b830036fb4..5ed7846639bf 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3144,6 +3144,7 @@
 #define PCI_DEVICE_ID_INTEL_HDA_CML_S	0xa3f0
 #define PCI_DEVICE_ID_INTEL_HDA_LNL_P	0xa828
 #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152
+#define PCI_DEVICE_ID_INTEL_HDA_NVL	0xd328
 #define PCI_DEVICE_ID_INTEL_HDA_BMG	0xe2f7
 #define PCI_DEVICE_ID_INTEL_HDA_PTL_H	0xe328
 #define PCI_DEVICE_ID_INTEL_HDA_PTL	0xe428
-- 
2.52.0

