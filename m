Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378C9384229
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772625075; cv=none; b=ItiKEmB4MCCY0MCA5EMUfN0gU313fp5ZPAZwVklCQnwcnooyaTQsf4Ss34Tpyp6crtjVN1/8jpKQXhI0gPkzSGFcwterfyXYil1PMDg2L9X8WaBWZGD5pB6oopO4TBKh/K64gGr6QPqVvxH+UjeHKFEiaF1sAYEHULoq33ErenE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772625075; c=relaxed/simple;
	bh=SFkQaymkmw7BeebFyk1Xm+ip7ieTvvBZLJrsQwoa9Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lAUQVWdqLsz1KuABfFi6LohRT8lafoTjzjwplGCiUg0ThGURKbQgqjYN6+6xHDOX5noa26PQzeFKql36wlO+40mzm8o19qbp25lch9ILmQG6Z5Qna+obRI1mmjZzdzbNIwzqPD0CkzX3d5l2muOCe59B2SHL8oklpGz2hSLn0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rx9GX3NA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5PV4Wu1y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rx9GX3NA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5PV4Wu1y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rx9GX3NA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5PV4Wu1y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rx9GX3NA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5PV4Wu1y"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8477F5BE08;
	Wed,  4 Mar 2026 11:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772625072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nUoOsqWPWu62lPsUCO91lLwVluM1zFHwhqKul1eNr7Y=;
	b=Rx9GX3NAzyQiOxIUFbidpVLVb8Ik8o0+MJeX4m0k/94HVfkSSLvdCIsedFXeBFf/ohe+wM
	Tr/0Z6v6aMwLFrfRpjoO/ySXHNGPC3sYoAC9mNPRySCoZgwgXwdwjrPiSW/WhwfHYBzC8J
	7ZRZ65NddvlKi2LNFgC3UDRklDeyr6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772625072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nUoOsqWPWu62lPsUCO91lLwVluM1zFHwhqKul1eNr7Y=;
	b=5PV4Wu1yRUfj7CrnPf1gbqEB9+qxHtojCePZftryAf2TNqK+cp10uJB7FMkk9Zf0k/F10b
	i8CrJ6kjffuImHBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772625072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nUoOsqWPWu62lPsUCO91lLwVluM1zFHwhqKul1eNr7Y=;
	b=Rx9GX3NAzyQiOxIUFbidpVLVb8Ik8o0+MJeX4m0k/94HVfkSSLvdCIsedFXeBFf/ohe+wM
	Tr/0Z6v6aMwLFrfRpjoO/ySXHNGPC3sYoAC9mNPRySCoZgwgXwdwjrPiSW/WhwfHYBzC8J
	7ZRZ65NddvlKi2LNFgC3UDRklDeyr6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772625072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nUoOsqWPWu62lPsUCO91lLwVluM1zFHwhqKul1eNr7Y=;
	b=5PV4Wu1yRUfj7CrnPf1gbqEB9+qxHtojCePZftryAf2TNqK+cp10uJB7FMkk9Zf0k/F10b
	i8CrJ6kjffuImHBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16A4D3EA69;
	Wed,  4 Mar 2026 11:51:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OC9iArAcqGl+ZgAAD6G6ig
	(envelope-from <clopez@suse.de>); Wed, 04 Mar 2026 11:51:12 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] checkpatch: deprecate pcim_iomap_table() and pcim_iomap_regions()
Date: Wed,  4 Mar 2026 12:50:34 +0100
Message-ID: <20260304115032.400104-3-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.de,canonical.com,perches.com,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 

pcim_iomap_table() and pcim_iomap_regions() have been deprecated
since e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()") and d140f80f6035 ("PCI: Deprecate
pcim_iomap_regions() in favor of pcim_iomap_region()") respectively.
Teach checkpatch about these to prevent adding new users of these
functions.

Signed-off-by: Carlos López <clopez@suse.de>
---
v2: removed --base=auto noise from the patch
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e56374662ff7..53ee3db59b58 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -866,6 +866,8 @@ our %deprecated_apis = (
 	"idr_init_base"				=> "xa_init_flags",
 	"rcu_read_lock_trace"			=> "rcu_read_lock_tasks_trace",
 	"rcu_read_unlock_trace"			=> "rcu_read_unlock_tasks_trace",
+	"pcim_iomap_regions"			=> "pcim_iomap_region",
+	"pcim_iomap_table"			=> "pcim_iomap",
 );
 
 #Create a search pattern for all these strings to speed up a loop below
-- 
2.51.0

