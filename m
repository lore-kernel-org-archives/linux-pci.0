Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FAF381B1C;
	Mon,  6 Jul 2026 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342630; cv=none; b=Gv+ZX7oRry32jTozi1td7kzTopq0HPa4VkV39+Sazp/LPPBJDhoovIcIduAYrAIIYThb/1jQIJaIY034TOx61EoG0CFfsSUwk0wDjRdnimvG8zQ+1xPb2wbsqX2hXb/p2ishRSBDr03jR+ns4gNimTSyGln4lC+8dpxFAddcJDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342630; c=relaxed/simple;
	bh=VUZIkXufgwBW/JMrzaWRzp9hNDKyQfFV0tnX6ij9HlE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JfOK28rkaWNN+mNjp2umjOYrEtRqIrz1tXqGr1UQFKj9R8fPB49m4tb5M7w+JkWpy0cg962Jmdm/pUYTz+uav7QVut0rqaZqrysX0I4WJYHZ1KBKYztWFs8sghnHWCr+mKfPG2IeCa5d+Bja9s1aSAN4RKj0y8OFmgzAr6+bnKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkBcHryg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkBcHryg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9581F000E9;
	Mon,  6 Jul 2026 12:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342628;
	bh=GCyaRI2v+Msir348xm9C8l5PWA+QlX0OzfCc70e43Ik=;
	h=Date:From:To:Subject;
	b=QkBcHrygH5Ere2gGZ4IyKeQAgDzFCP4pMLmbC0I83R0o1GjlJpPUMR+jerIqInvf7
	 7X0TiE/VD50oxAlFigliU+PgUxb81uTzPO9uvaxv3JXsOEV3qsy9u1lA5EI9qafcqU
	 3pw36XTN6XIZ7UinHMVqp31cmfLQjQxoU63HdjksOhilnPFgda6VmTqafvtpB0cfUp
	 fAVe437fW9nOmEqL35sDZ3DM2BukTie3OJG+njNbtHwoeP6oAkyFI57AsiHuKoWfsj
	 zps9YuvZ9SGDFXJMMh3P+OJ10C8qX7+nR1nfPR8h5TX0696OcqXg9O4K/KYynZ2fSv
	 IXF1Ji/Ip+wIg==
Date: Mon, 6 Jul 2026 21:57:06 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Linux PCI <linux-pci@vger.kernel.org>, 
	Linux IOMMU <iommu@lists.linux.dev>, Linux KVM <kvm@vger.kernel.org>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, =?utf-8?B?SsO2cmc=?= Roedel <joro@8bytes.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: The VFIO/IOMMU/PCI MC at LPC 2026
Message-ID: <20260706123705.GB3821042@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello everyone!

A quick reminder that our VFIO/IOMMU/PCI micro-conference (MC) has been
accepted for this year's Linux Plumbers Conference, and it is now open for
topic submissions.  More at:

  https://lpc.events/event/20/contributions/2326/

LPC 2026 will be held in Prague, Czechia, from the 5th to the 7th of October.
Please note that this year presenters and micro-conference topic leads are
expected to attend in person; remote presentations will be considered only on
an emergency basis.  See https://lpc.events for more details and the latest
updates.

If you have a topic you would like to bring to the MC, please submit it through
the official Call for Proposals (CfP) process at:

  https://lpc.events/event/20/abstracts/

Choose "Submit new abstract" and make sure to select the "VFIO/IOMMU/PCI MC"
entry from the Track drop-down menu, so that your proposal is submitted against
the correct track.

Two dates are worth keeping in mind:

  - 10th of July: submit a topic by this date to become eligible to
    pre-register for the conference.

  - 7th of August, 23:59 UTC: the Call for Proposals closes.  This is the
    final deadline, shared by all micro-conferences.

The sooner the better, as it gives us more time to review the submissions and
plan the schedule ahead.  And do remember: you can submit early and refine the
proposal later; there will be time.  Even a rough draft is fine, so please
don't hesitate.

If you are new to Linux Plumbers Conference, or you are not quite sure what
a micro-conference topic should look like, Steven Rostedt's write-up on the
ideal micro-conference topic session is well worth a read before you submit:

  > Hello Microconference runners and topic presenters,
  >
  >
  > This is a reminder that microconeference topics are not presentations.
  > Think of the "Problem Statement" you would like to present. Any
  > presentation should be short and direct to the point. The goal of the
  > presentation is to bring the audience up to speed, so that they can offer
  > useful contributions to the issue you want to address.
  >
  > Ideal presentations should be no more than a third of the allotted time for
  > the topic. If your topic time slot is 15 minutes, present for no more than
  > 5 minutes. If your topic is 30 minutes, present for no more than 10
  > minutes. At a maximum, do not present for any more than half the allotted
  > time. Maximum for 15 minute time slots is a 7 minute presentation. Maximum
  > for 30 minutes is a 15 minute presentation.
  >
  > The best slides are those that can be referenced during the discussion. If
  > you propose an API, have a slide with that API. If you propose a work flow,
  > have a work flow diagram. Something you can go back to and point to if the
  > discussion needs more clarification.
  >
  > And please have some slides that explain what you want to discuss. If only
  > three people in the session understand the problem, you will only have
  > three people in that discussion and you will lose out on the potential of
  > diversity in ideas, that a wider group can bring.
  >
  > Remember, you are not giving a talk. You are leading a discussion to a
  > problem you would like to solve. Bring as much to the table that can assist
  > you in that goal.
  >
  > And I would like to sincerely thank all of you in your participation in
  > this year's Linux Plumbers microconferences. Without your work, Linux
  > Plumbers would not be as successful as it is today.
  >
  > Steven Rostedt
  > Linux Plumbers Microconference Chair

In short, a micro-conference topic is a problem statement rather than a
finished talk.  The idea is to explain a problem you are currently working on,
show what you have tried so far, and then use the time in the room to discuss
how best to solve it.  More at:

  https://lpc.events/blog/current/index.php/2023/06/26/the-ideal-microconference-topic-session/

As always, please get in touch with me directly, or with any of the other
organisers, if you need any assistance or have any questions.

Looking forward to seeing you all in Prague!

Thank you!

	Alex, Bjorn, Jörg, Lorenzo and Krzysztof
