Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:40032 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbbCFMA7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2015 07:00:59 -0500
Received: by wevk48 with SMTP id k48so15537299wev.7
        for <linux-pci@vger.kernel.org>; Fri, 06 Mar 2015 04:00:58 -0800 (PST)
MIME-Version: 1.0
Reply-To: pricardofc@gmail.com
Date: Fri, 6 Mar 2015 12:00:56 +0000
Message-ID: <CAH9N0t_14e1TzVZpFxq7pwTKJFN7cdXXqVd64_3e2iknUMG1kw@mail.gmail.com>
Subject: MRL Sensor or Attention Button event and hotplug scripts
From: Paulo Fortuna Carvalho <pricardofc@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Good morning,
I have an ATCA systema with a PCIe endpoint card.
I need to stop applications from running everytime i remove the PCIe
endpoint before remove event occurs.
For that task I have 2 hot-add events a MRL Sensor event and the
PRESENCE OFF event.
At the moment with the hotplug scripts (.rules files) I can configure
the behaviour of remove procedure using the "remove" tag. I dont know
if there is  the possibility to use the same script (and which tag)
for the MRL Sensor event.
In addiction, is it better to use the MRL Sensor event or the
Attention Button for this purpose?
Thanks,
Ricardo Fortuna Carvalho
