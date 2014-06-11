Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from tor-sh10.fullhost.com ([162.219.163.6]:45023 "EHLO
	tor-sh10.fullhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbaFKUAb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jun 2014 16:00:31 -0400
Received: from cpe0013f7f0fb44-cm0013f7f0fb40.cpe.net.cable.rogers.com ([174.112.49.58]:41560 helo=[192.168.0.185])
	by tor-sh10.fullhost.com with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.82)
	(envelope-from <patrick@spellingbeewinnars.org>)
	id 1Wunsp-001aZg-Ra
	for linux-pci@vger.kernel.org; Wed, 11 Jun 2014 15:08:27 -0400
Message-ID: <5398A8CB.9000007@spellingbeewinnars.org>
Date: Wed, 11 Jun 2014 15:06:51 -0400
From: Patrick <patrick@spellingbeewinnars.org>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: updating firmware with setpci ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Everyone

I hope i have understood the documentation and I am basically in the 
right place.

I repair circuit boards used with scientific instruments. I have several 
PCI cards that I believe are functioning properly otherwise but a driver 
for them cannot be loaded under windows.

Can I use lspci to retrieve header information from a healthy card and 
then write this to another card using setpci ?

The -m option speaks about machine readable but it still looks like 
plain text to me. Will setpci take this and write it as binary to 
another card ?

If anyone could help I would really-really appreciate this, I don't have 
much money right now and this job will really help if I can complete it.

Thanks for reading-Patrick



