Return-Path: <SRS0=Dmk6=FY=ucw.cz=mj+f-020318+helgaas=kernel.org@kernel.org>
Return-Path: <SRS0=Dmk6=FY=ucw.cz=mj+f-020318+helgaas=kernel.org@kernel.org>
Date: Fri, 2 Mar 2018 12:30:53 +0100
From: Martin Mares <mj@ucw.cz>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Make DevCtl, DevSta, and AER decoding more
 consistent
Message-ID: <mj+md-20180302.113045.60265.nikam@ucw.cz>
References: <20180131211913.66990.27599.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180131211913.66990.27599.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi,

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Change DevCtl error reporting enables so they match the corresponding
> DevSta bits:
[...]

thanks, applied.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"In theory, practice and theory are the same, but in practice they are different." -- Larry McVoy
