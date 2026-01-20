Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF67D34EF06
	for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 19:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768936061; cv=none; b=ifl2vrn/hilcPn3UmRSsaSWq2OS2q4T3rZ+sTaTUoS1rq6Gu6bNvl6OFY/maRJT+kD+gFDSh+zE0JMI1zTxzIvkAdrtXZz1eDrpN4g9YVXOV+BhRIX591+1pFxWf5Zab0yG+Qt1dh6AvpdPUNQPstqZ7BgHg9oQTNcd5lrIw88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768936061; c=relaxed/simple;
	bh=/QoGK8Xt5gS0+41Fy4DL1+vjrBd3h4rPTW+Pf8FHAlo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyC3/5oNtj+0upHqMQ8yeuvwe0WjTtuThVcP/rHgLG9oQC56X8GaDBTAey4MVyjWfv1UMc+BbjcpHUCYuAOQStpwQmC/E90BqxTa3ZSxmhYK2XWtm25USMFPDB97QaDttBOK+wPSUXuiAgK+X3eDQZIhntMQ9kLND6KPUzeDrq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H96BX4lm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5qH3MMrj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H96BX4lm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5qH3MMrj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H96BX4lm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5qH3MMrj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H96BX4lm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5qH3MMrj"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 15DB25BCC3;
	Tue, 20 Jan 2026 19:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768936056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zJ1Z8IYZMWTEDeNVFkUDqCyvMkBoL753dOOBuK9zmSk=;
	b=H96BX4lmrkDW8B9QVcImB3K1isMfcrDrXSSaWceaJfWyxmj2/t3/o8w30xZEyFagxwCEZP
	i8GFlyZfN9NwEEp0SR4jzAuozgtwPEoRd+2q0/w2ThHOcjw+CGz4ZJ4sqKZlJr/+6xvt6a
	UXGxbgrjWHVxXMRWa93aDzCTjGmOSUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768936056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zJ1Z8IYZMWTEDeNVFkUDqCyvMkBoL753dOOBuK9zmSk=;
	b=5qH3MMrjsgb9Pj5YzSKnvvT/Oz2+jJ0g8/CaCT6jmjMvGVYFzaurFAWnHkVjvgvSZg/44A
	AlloC9As4g4xhmDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768936056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zJ1Z8IYZMWTEDeNVFkUDqCyvMkBoL753dOOBuK9zmSk=;
	b=H96BX4lmrkDW8B9QVcImB3K1isMfcrDrXSSaWceaJfWyxmj2/t3/o8w30xZEyFagxwCEZP
	i8GFlyZfN9NwEEp0SR4jzAuozgtwPEoRd+2q0/w2ThHOcjw+CGz4ZJ4sqKZlJr/+6xvt6a
	UXGxbgrjWHVxXMRWa93aDzCTjGmOSUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768936056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zJ1Z8IYZMWTEDeNVFkUDqCyvMkBoL753dOOBuK9zmSk=;
	b=5qH3MMrjsgb9Pj5YzSKnvvT/Oz2+jJ0g8/CaCT6jmjMvGVYFzaurFAWnHkVjvgvSZg/44A
	AlloC9As4g4xhmDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B07A93EA63;
	Tue, 20 Jan 2026 19:07:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KJmhKXfSb2kXcgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 20 Jan 2026 19:07:35 +0000
Date: Tue, 20 Jan 2026 20:07:35 +0100
Message-ID: <87fr80rtl4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de,
	bhelgaas@google.com,
	linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	linux-kernel@vger.kernel.org,
	kw@linux.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/4] ASoC/SOF/PCI/Intel: Support for Nova Lake
In-Reply-To: <20260120083148.12063-1-peter.ujfalusi@linux.intel.com>
References: <20260120083148.12063-1-peter.ujfalusi@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,suse.de,google.com,vger.kernel.org,linux.intel.com,linux.dev,linux.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Tue, 20 Jan 2026 09:31:44 +0100,
Peter Ujfalusi wrote:
> 
> Hi,
> 
> this series adds audio support for the NVL variant of the
> Nova Lake family.
> NVL also based on ACE4 audio subsystem, but with higher clock
> rate, more DSP memory and more DSP cores (4 vs 2) compared to
> NVL-S.

It looks like that the ASoC patch is based on the recent change that
isn't merged yet in my tree, so this series should go over ASoC tree
for now, supposedly.

Mark, could you take them (probably with minor corrections of subject
as Bjorn suggested in the thread)?

For HD-audio stuff:
Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi
