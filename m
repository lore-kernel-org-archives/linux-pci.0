Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:45335 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752506Ab2ADTX6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2012 14:23:58 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 10E3620ED9
	for <linux-pci@vger.kernel.org>; Wed,  4 Jan 2012 14:23:58 -0500 (EST)
Date: Wed, 4 Jan 2012 11:22:34 -0800
From: Greg KH <greg@kroah.com>
To: Pratyush Anand <pratyush.anand@st.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>,
	"e1000-devel@lists.sourceforge.net"
	<e1000-devel@lists.sourceforge.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Deepak SIKRI <deepak.sikri@st.com>,
	Bhavna YADAV <bhavna.yadav@st.com>, linux-pci@vger.kernel.org
Subject: Re: Detected Hardware Unit Hang on Intel Wired Ethernet
Message-ID: <20120104192234.GC18214@kroah.com>
References: <CAHM4w1=i5dYy+ReqMO=m6W96CNaQ+O=jw+pKQok0nmjb5-fNAw@mail.gmail.com>
 <4F043190.70405@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F043190.70405@st.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 04, 2012 at 04:31:36PM +0530, Pratyush Anand wrote:
> Adding PCI mailing list too, as problem is coming only when MSI is enabled.
> 
> If I connect an PCIe analyzer, I see that at the time of issue
> MRd(64) for 32 words has been issued with a wrong 64 bit address
> from ethernet card to my RC.
> In the normal course it always issues MRd(32) only.

Bug in your pcie firmware controller?

