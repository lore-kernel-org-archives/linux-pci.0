Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:62398 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbbBJQtl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Feb 2015 11:49:41 -0500
Received: by mail-ig0-f179.google.com with SMTP id l13so24843873iga.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 08:49:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54D7AE67.1090007@nwtrail.com>
References: <54C81B4E.7060900@nwtrail.com> <CAErSpo6P-gm1xFjLrbKBU+P3zUHY-RGMkhaVpWsK7vDz_wK=YQ@mail.gmail.com>
 <54CBB062.4040801@nwtrail.com> <CAE9FiQUxD8g4KG9CYe1znb5Lw5skkq=9QSOgkmGUDbhsaDq2Qw@mail.gmail.com>
 <54CFBC0E.4080102@nwtrail.com> <CAE9FiQUT5j1PDw5c0X-k_E+0TbwCdrX1nbqk8rKzxAKxRLqvEg@mail.gmail.com>
 <54D160B5.70006@nwtrail.com> <CAE9FiQVjiCSj21eqevBOYz42o=aiPPMLM_g+65v8CJWgcdq=pg@mail.gmail.com>
 <54D6C6CB.6060904@nwtrail.com> <CAE9FiQW+z0GtUXCTnr42N7pQ-3xVTe_3EsmkAhWk7ehkZDq_Qw@mail.gmail.com>
 <54D7AE67.1090007@nwtrail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 10 Feb 2015 10:49:20 -0600
Message-ID: <CAErSpo4ZYfs9EhdZMXGdjbDY4WUfTNFz+CPBq-Gx3eQ563Fogw@mail.gmail.com>
Subject: Re: [problem] mpt2sas load fails with LSISAS2008
To: pjay@nwtrail.com
Cc: Yinghai Lu <yinghai@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We need to work out what's going wrong here before we rush into a band-aid.

What changed between v3.4 and v3.4.1 that exposed this problem?  "git
log --oneline v3.4..v3.4.1" doesn't show any likely culprits.  Paul,
are those the versions you tested?  Your dmesg logs at
https://bugzilla.kernel.org/show_bug.cgi?id=92351 show
"3.4.0-030400-generic" and "3.4.1-030401-generic" but I don't know
whether those are precisely v3.4 and v3.4.1.

I assume this system works fine with Windows, and I doubt Windows has
a hack like "never move LSI devices."  So it would be useful to know
if we're doing something stupid in Linux that makes us trip over this.
Paul, if you happen to have Windows on this machine as well, a
complete AIDA64 report (free trial version at http://www.aida64.com)
would show what Windows did.

The resource allocation we're doing is related SR-IOV, and
unfortunately we don't print enough information in dmesg to figure
everything out.  Paul, can you attach the complete "lspci -vv" output
to the bugzilla?

Bjorn
